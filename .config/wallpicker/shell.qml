import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
    id: root

    // ── Layout ───────────────────────────────────────────────
    readonly property real cardH: 300
    readonly property real cardW: 150
    readonly property real activeW: 520
    readonly property real skew: 0.2
    readonly property string font: "FiraCode Nerd Font Propo"

    // ── Scheme colours (overwritten from scheme.json) ────────
    property color accent: "#a8c7fa"
    property color fgAccent: "#062e6f"
    property color surface: "#1b1b1f"
    property color fgSurface: "#e3e2e6"
    property color outline: "#8e9099"

    // ── Data ─────────────────────────────────────────────────
    property var all: []
    property var shown: []
    property string hueFilter: "all"
    property string query: ""
    readonly property string currentReal: Quickshell.env("WALLPICKER_CURRENT") ?? ""

    readonly property var hues: [
        { id: "red",    color: "#ff453a" },
        { id: "orange", color: "#ff9f0a" },
        { id: "yellow", color: "#ffd60a" },
        { id: "green",  color: "#30d158" },
        { id: "blue",   color: "#0a84ff" },
        { id: "purple", color: "#9b59ff" },
        { id: "pink",   color: "#ff5fa2" },
        { id: "gray",   color: "#9e9e9e" }
    ]

    function alpha(c, a) { return Qt.rgba(c.r, c.g, c.b, a); }

    function applyFilter() {
        const q = query.toLowerCase();
        shown = all.filter(w => (hueFilter === "all" || w.hue === hueFilter)
                             && (q === "" || w.name.toLowerCase().indexOf(q) !== -1));
        Qt.callLater(() => {
            if (shown.length === 0) return;
            let i = shown.findIndex(w => w.real === currentReal);
            if (i < 0) i = 0;
            carousel.currentIndex = i;
            carousel.positionViewAtIndex(i, ListView.Center);
        });
    }

    function cycleHue(step) {
        const ids = ["all"].concat(hues.map(h => h.id));
        const i = ids.indexOf(hueFilter);
        hueFilter = ids[(i + step + ids.length) % ids.length];
        applyFilter();
    }

    function run(cmd) {
        if (applyProc.running) return;
        win.visible = false;
        applyProc.command = cmd;
        applyProc.running = true;
    }

    function applyCurrent() {
        if (carousel.currentIndex >= 0 && carousel.currentIndex < shown.length)
            run(["caelestia", "wallpaper", "-f", shown[carousel.currentIndex].path]);
    }

    Process {
        id: applyProc
        onExited: Qt.quit()
    }

    FileView {
        id: indexFile
        path: Quickshell.env("WALLPICKER_INDEX") ?? ""
        blockLoading: true
    }

    FileView {
        id: schemeFile
        path: Quickshell.env("WALLPICKER_SCHEME") ?? ""
        blockLoading: true
    }

    Component.onCompleted: {
        try {
            const c = JSON.parse(schemeFile.text()).colours;
            accent = "#" + c.primary;
            fgAccent = "#" + c.onPrimary;
            surface = "#" + c.surfaceContainer;
            fgSurface = "#" + c.onSurface;
            outline = "#" + c.outline;
        } catch (e) {
            console.warn("wallpicker: scheme not loaded, using defaults:", e);
        }
        try {
            all = JSON.parse(indexFile.text());
        } catch (e) {
            console.warn("wallpicker: index not loaded:", e);
            all = [];
        }
        applyFilter();
        search.forceActiveFocus();
    }

    PanelWindow {
        id: win

        anchors { top: true; bottom: true; left: true; right: true }
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        WlrLayershell.namespace: "wallpicker"

        // Dimmed backdrop; click outside the carousel to close.
        Rectangle {
            id: backdrop
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0.45)
            opacity: 0
            Component.onCompleted: opacity = 1
            Behavior on opacity { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }

            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }

        // ── Toolbar: random, colour filters, search ──────────
        Rectangle {
            id: toolbar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: carousel.top
            anchors.bottomMargin: 28
            height: 44
            radius: 22
            width: tools.implicitWidth + 20
            color: root.alpha(root.surface, 0.88)
            border.width: 1
            border.color: root.alpha(root.outline, 0.35)

            MouseArea { anchors.fill: parent }   // swallow clicks so the backdrop does not close

            Row {
                id: tools
                anchors.centerIn: parent
                spacing: 8

                // "All" toggle
                Rectangle {
                    width: 30; height: 30; radius: 10
                    anchors.verticalCenter: parent.verticalCenter
                    color: root.hueFilter === "all" ? root.alpha(root.accent, 0.25) : "transparent"
                    border.width: root.hueFilter === "all" ? 2 : 0
                    border.color: root.accent
                    Text {
                        anchors.centerIn: parent
                        text: "󰕰"
                        font.family: root.font
                        font.pixelSize: 16
                        color: root.fgSurface
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: { root.hueFilter = "all"; root.applyFilter(); }
                    }
                }

                // Random
                Rectangle {
                    width: 30; height: 30; radius: 10
                    anchors.verticalCenter: parent.verticalCenter
                    color: randomArea.containsMouse ? root.alpha(root.accent, 0.2) : "transparent"
                    Text {
                        anchors.centerIn: parent
                        text: "󰒝"
                        font.family: root.font
                        font.pixelSize: 16
                        color: root.fgSurface
                    }
                    MouseArea {
                        id: randomArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.run(["caelestia", "wallpaper", "-r"])
                    }
                }

                Rectangle {
                    width: 1; height: 22
                    anchors.verticalCenter: parent.verticalCenter
                    color: root.alpha(root.outline, 0.4)
                }

                Repeater {
                    model: root.hues
                    delegate: Rectangle {
                        id: dot
                        required property var modelData
                        readonly property bool selected: root.hueFilter === modelData.id
                        width: 22; height: 22; radius: 11
                        anchors.verticalCenter: parent.verticalCenter
                        color: modelData.color
                        scale: selected ? 1.15 : (dotArea.containsMouse ? 1.08 : 1.0)
                        border.width: selected ? 3 : 0
                        border.color: root.fgSurface
                        Behavior on scale { NumberAnimation { duration: 120 } }
                        MouseArea {
                            id: dotArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.hueFilter = dot.selected ? "all" : dot.modelData.id;
                                root.applyFilter();
                            }
                        }
                    }
                }

                Rectangle {
                    width: 1; height: 22
                    anchors.verticalCenter: parent.verticalCenter
                    color: root.alpha(root.outline, 0.4)
                }

                // Search
                Rectangle {
                    width: 190; height: 30; radius: 15
                    anchors.verticalCenter: parent.verticalCenter
                    color: root.alpha(root.fgSurface, 0.06)
                    border.width: search.activeFocus ? 1 : 0
                    border.color: root.accent

                    Text {
                        id: searchIcon
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: ""
                        font.family: root.font
                        font.pixelSize: 13
                        color: root.alpha(root.fgSurface, 0.7)
                    }

                    TextInput {
                        id: search
                        anchors.left: searchIcon.right
                        anchors.leftMargin: 8
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: root.font
                        font.pixelSize: 13
                        color: root.fgSurface
                        selectionColor: root.accent
                        selectedTextColor: root.fgAccent
                        clip: true
                        focus: true

                        onTextChanged: { root.query = text; root.applyFilter(); }

                        Keys.onPressed: event => {
                            switch (event.key) {
                            case Qt.Key_Left:
                                carousel.decrementCurrentIndex(); event.accepted = true; break;
                            case Qt.Key_Right:
                                carousel.incrementCurrentIndex(); event.accepted = true; break;
                            case Qt.Key_Return:
                            case Qt.Key_Enter:
                                root.applyCurrent(); event.accepted = true; break;
                            case Qt.Key_Tab:
                                root.cycleHue(1); event.accepted = true; break;
                            case Qt.Key_Backtab:
                                root.cycleHue(-1); event.accepted = true; break;
                            case Qt.Key_Escape:
                                if (text.length > 0) text = ""; else Qt.quit();
                                event.accepted = true; break;
                            }
                        }

                        Text {
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            visible: search.text.length === 0
                            text: "search…"
                            font: search.font
                            color: root.alpha(root.fgSurface, 0.45)
                        }
                    }
                }
            }
        }

        // ── Carousel ─────────────────────────────────────────
        ListView {
            id: carousel
            anchors.centerIn: parent
            width: parent.width
            height: root.cardH
            orientation: ListView.Horizontal
            spacing: 10
            interactive: false
            model: root.shown
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: width / 2 - root.activeW / 2
            preferredHighlightEnd: width / 2 + root.activeW / 2
            highlightMoveDuration: 280
            cacheBuffer: 1600

            WheelHandler {
                onWheel: event => {
                    const d = event.angleDelta.y !== 0 ? event.angleDelta.y : -event.angleDelta.x;
                    if (d < 0) carousel.incrementCurrentIndex();
                    else if (d > 0) carousel.decrementCurrentIndex();
                }
            }

            delegate: Item {
                id: card
                required property var modelData
                required property int index
                readonly property bool active: ListView.isCurrentItem

                width: active ? root.activeW : root.cardW
                height: root.cardH
                z: active ? 2 : 1
                Behavior on width { NumberAnimation { duration: 280; easing.type: Easing.OutCubic } }

                // Parallelogram: shear the clipping box, counter-shear the image so it stays undistorted.
                Item {
                    anchors.fill: parent
                    clip: true
                    transform: Matrix4x4 {
                        matrix: Qt.matrix4x4(1, -root.skew, 0, root.skew * root.cardH / 2,
                                             0, 1, 0, 0,
                                             0, 0, 1, 0,
                                             0, 0, 0, 1)
                    }

                    Image {
                        x: -root.skew * root.cardH / 2
                        width: parent.width + root.skew * root.cardH
                        height: parent.height
                        source: "file://" + card.modelData.thumb
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        cache: true
                        sourceSize.width: 640
                        transform: Matrix4x4 {
                            matrix: Qt.matrix4x4(1, root.skew, 0, -root.skew * root.cardH / 2,
                                                 0, 1, 0, 0,
                                                 0, 0, 1, 0,
                                                 0, 0, 0, 1)
                        }
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "black"
                        opacity: card.active ? 0 : (cardArea.containsMouse ? 0.15 : 0.4)
                        Behavior on opacity { NumberAnimation { duration: 180 } }
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        border.width: card.active ? 3 : 1
                        border.color: card.active ? root.accent : root.alpha(root.fgSurface, 0.25)
                    }
                }

                MouseArea {
                    id: cardArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (card.active) root.applyCurrent();
                        else carousel.currentIndex = card.index;
                    }
                }
            }
        }

        // ── Caption ──────────────────────────────────────────
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: carousel.bottom
            anchors.topMargin: 22
            height: 32
            radius: 16
            width: caption.implicitWidth + 28
            visible: caption.text.length > 0
            color: root.alpha(root.surface, 0.88)
            border.width: 1
            border.color: root.alpha(root.outline, 0.35)

            Text {
                id: caption
                anchors.centerIn: parent
                font.family: root.font
                font.pixelSize: 13
                color: root.fgSurface
                text: root.shown.length === 0
                      ? "no wallpapers match"
                      : (carousel.currentIndex >= 0 && carousel.currentIndex < root.shown.length
                         ? root.shown[carousel.currentIndex].name + "   " + (carousel.currentIndex + 1) + "/" + root.shown.length
                         : "")
            }
        }
    }
}

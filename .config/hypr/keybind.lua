local scrPath = (os.getenv("HOME") or "") .. "/.config/hypr/Scripts"
local mainMod = "SUPER"
local TERMINAL = "kitty"
local EDITOR = "kitty --class nvim -e nvim"
local EXPLORER = "thunar"
local BROWSER = "firefox"

local KEY = {
	TERMINAL = ("%s + RETURN"):format(mainMod),
	EXPLORER = ("%s + E"):format(mainMod),
	EDITOR = ("%s + C"):format(mainMod),
	BROWSER = ("%s + B"):format(mainMod),
	LAUNCHER = ("%s + D"):format(mainMod),
	LOCK = ("%s + L"):format(mainMod),
	SETTINGS = ("%s + T"):format(mainMod),
	CHEATSHEET_TOGGLE = ("%s + H"):format(mainMod),
	CHEATSHEET_REFRESH = ("%s + SHIFT + H"):format(mainMod),
	HYPR_KEYS_PANEL = ("%s + K"):format(mainMod),
	MUSIC = ("%s + M"):format(mainMod),
	VIDEO = ("%s + V"):format(mainMod),

	CLOSE = ("%s + Q"):format(mainMod),
	FLOAT = ("%s + W"):format(mainMod),
	FULLSCREEN = ("%s + F"):format(mainMod),

	WORKSPACE_NEXT_MONITOR = ("%s + tab"):format(mainMod),
	WORKSPACE_PREV_MONITOR = ("%s + SHIFT + tab"):format(mainMod),

	FOCUS_LEFT = ("%s + left"):format(mainMod),
	FOCUS_RIGHT = ("%s + right"):format(mainMod),
	FOCUS_UP = ("%s + up"):format(mainMod),
	FOCUS_DOWN = ("%s + down"):format(mainMod),

	RESIZE_RIGHT = ("%s + SHIFT + right"):format(mainMod),
	RESIZE_LEFT = ("%s + SHIFT + left"):format(mainMod),
	RESIZE_UP = ("%s + SHIFT + up"):format(mainMod),
	RESIZE_DOWN = ("%s + SHIFT + down"):format(mainMod),

	MOVE_SWAP_LEFT = ("%s + SHIFT + CTRL + left"):format(mainMod),
	MOVE_SWAP_RIGHT = ("%s + SHIFT + CTRL + right"):format(mainMod),
	MOVE_SWAP_UP = ("%s + SHIFT + CTRL + up"):format(mainMod),
	MOVE_SWAP_DOWN = ("%s + SHIFT + CTRL + down"):format(mainMod),

	WORKSPACE_NEXT = ("%s + CTRL + right"):format(mainMod),
	WORKSPACE_PREV = ("%s + CTRL + left"):format(mainMod),
	WORKSPACE_EMPTY = ("%s + CTRL + down"):format(mainMod),

	MOVE_TO_NEXT_WORKSPACE = ("%s + CTRL + ALT + right"):format(mainMod),
	MOVE_TO_PREV_WORKSPACE = ("%s + CTRL + ALT + left"):format(mainMod),

	SCROLL_WORKSPACE_NEXT = ("%s + mouse_down"):format(mainMod),
	SCROLL_WORKSPACE_PREV = ("%s + mouse_up"):format(mainMod),

	MOUSE_DRAG = ("%s + mouse:272"):format(mainMod),
	MOUSE_RESIZE = ("%s + mouse:273"):format(mainMod),
	RESIZE_MODE = ("%s + X"):format(mainMod),
}

-- 1. Applications
hl.bind(KEY.TERMINAL, hl.dsp.exec_cmd(TERMINAL), { description = "Terminal" })
hl.bind(KEY.EXPLORER, hl.dsp.exec_cmd(EXPLORER), { description = "File manager" })
hl.bind(KEY.EDITOR, hl.dsp.exec_cmd(EDITOR), { description = "Code editor" })
hl.bind(KEY.BROWSER, hl.dsp.exec_cmd(BROWSER), { description = "Browser" })
hl.bind(KEY.LAUNCHER, hl.dsp.exec_cmd([[fuzzel]]), { description = "Toggle launcher" })
hl.bind(KEY.LOCK, hl.dsp.exec_cmd([[loginctl lock-session]]), { description =  "Lock screen " })
hl.bind(KEY.SETTINGS, hl.dsp.exec_cmd([[kitty --class nvim -e nvim ~/.config/hypr]]), { description = "Toggle settings" })
-- Super+M free (mail client removed)
hl.bind(KEY.VIDEO, hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/video-picker"), { description = "Video player" })

-- 2. Window Management
hl.bind(KEY.CLOSE, hl.dsp.window.close(), { description = "Close window" })
hl.bind(KEY.FLOAT, hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(KEY.FULLSCREEN, hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })

-- 3. Window Navigation & Layout
hl.bind(KEY.WORKSPACE_NEXT_MONITOR, hl.dsp.exec_cmd(scrPath .. "/workspace.sh"), { description = "Next workspace on monitor" })
hl.bind(KEY.WORKSPACE_PREV_MONITOR, hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace on monitor" })

hl.bind(KEY.FOCUS_LEFT, hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(KEY.FOCUS_RIGHT, hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(KEY.FOCUS_UP, hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(KEY.FOCUS_DOWN, hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

hl.bind("ALT + tab", hl.dsp.window.cycle_next(), { description = "Cycle windows" })

hl.bind(KEY.RESIZE_RIGHT, function() hl.exec_cmd("hyprctl dispatch resizeactive 30 0") end, { description = "Resize window right" })
hl.bind(KEY.RESIZE_LEFT, function() hl.exec_cmd("hyprctl dispatch resizeactive -30 0") end, { description = "Resize window left" })
hl.bind(KEY.RESIZE_UP, function() hl.exec_cmd("hyprctl dispatch resizeactive 0 -30") end, { description = "Resize window up" })
hl.bind(KEY.RESIZE_DOWN, function() hl.exec_cmd("hyprctl dispatch resizeactive 0 30") end, { description = "Resize window down" })

hl.bind(KEY.MOVE_SWAP_LEFT, function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive -30 0 || hyprctl dispatch movewindow l'") end, { description = "Move or swap window left" })
hl.bind(KEY.MOVE_SWAP_RIGHT, function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive 30 0 || hyprctl dispatch movewindow r'") end, { description = "Move or swap window right" })
hl.bind(KEY.MOVE_SWAP_UP, function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive 0 -30 || hyprctl dispatch movewindow u'") end, { description = "Move or swap window up" })
hl.bind(KEY.MOVE_SWAP_DOWN, function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive 0 30 || hyprctl dispatch movewindow d'") end, { description = "Move or swap window down" })

-- 4. Screenshots
hl.bind(("%s + SHIFT + S"):format(mainMod), hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot region"), { description = "Screenshot: region, save and copy" })
hl.bind(("%s + SHIFT + E"):format(mainMod), hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot annotate"), { description = "Screenshot: region, annotate" })
hl.bind(("%s + SHIFT + A"):format(mainMod), hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot screen"), { description = "Screenshot: monitor, save and copy" })
hl.bind("Print", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot region"), { description = "Screenshot: region" })
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot screen"), { description = "Screenshot: monitor" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot window"), { description = "Screenshot: active window" })

-- 5. Workspace Switching
for i = 1, 9 do
	local focusKey = ("%s + %d"):format(mainMod, i)
	local moveKey = ("%s + SHIFT + %d"):format(mainMod, i)
	hl.bind(focusKey, hl.dsp.focus({ workspace = i }), { description = "Workspace " .. i })
	hl.bind(moveKey, hl.dsp.window.move({ workspace = i }), { description = "Move to workspace " .. i })
end
hl.bind(("%s + 0"):format(mainMod), hl.dsp.focus({ workspace = 10 }), { description = "Workspace 10" })
hl.bind(("%s + SHIFT + 0"):format(mainMod), hl.dsp.window.move({ workspace = 10 }), { description = "Move to workspace 10" })

-- 6. Workspace Navigation
hl.bind(KEY.WORKSPACE_NEXT, hl.dsp.focus({ workspace = "r+1" }), { description = "Next workspace" })
hl.bind(KEY.WORKSPACE_PREV, hl.dsp.focus({ workspace = "r-1" }), { description = "Previous workspace" })
hl.bind(KEY.WORKSPACE_EMPTY, hl.dsp.focus({ workspace = "empty" }), { description = "Open empty workspace" })

-- 7. Move Window Across Workspaces
hl.bind(KEY.MOVE_TO_NEXT_WORKSPACE, hl.dsp.window.move({ workspace = "r+1" }), { description = "Move to next workspace" })
hl.bind(KEY.MOVE_TO_PREV_WORKSPACE, hl.dsp.window.move({ workspace = "r-1" }), { description = "Move to previous workspace" })

-- 8. Mouse Workspace Navigation
hl.bind(KEY.SCROLL_WORKSPACE_NEXT, hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll to next workspace" })
hl.bind(KEY.SCROLL_WORKSPACE_PREV, hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll to previous workspace" })

-- 9. Mouse Window Management
hl.bind(KEY.MOUSE_DRAG, hl.dsp.window.drag(),   { mouse = true, description = "Drag window" })
hl.bind(KEY.MOUSE_RESIZE, hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
hl.bind(KEY.RESIZE_MODE, hl.dsp.window.resize(), { description = "Resize mode" })



hl.bind(("%s + I"):format(mainMod), hl.dsp.exec_cmd("slack --ozone-platform=wayland --enable-features=WaylandWindowDecorations"), { description = "Slack" })

-- hl.bind(("%s + N"):format(mainMod), hl.dsp.exec_cmd("firefox"), { description = "Firefox" })
hl.bind(("%s + N"):format(mainMod), hl.dsp.exec_cmd([[makoctl restore]]), { description = "Notifications" })
hl.bind(("%s + G"):format(mainMod), hl.dsp.exec_cmd([[eww ping >/dev/null 2>&1 || { eww daemon; sleep 0.6; }; eww open --toggle dashboard]]), { description = "Dashboard" })
hl.bind(("%s + SHIFT + N"):format(mainMod), hl.dsp.exec_cmd([[makoctl dismiss --all]]), { description = "Clear all notifications" })

hl.bind(("%s + J"):format(mainMod), hl.dsp.exec_cmd("obsidian"), { description = "Obsidian" })
hl.bind(("%s + U"):format(mainMod), hl.dsp.exec_cmd("gtk-launch io.github.tobagin.karere"), { description = "Karere" })
hl.bind(("%s + SHIFT + W"):format(mainMod), hl.dsp.exec_cmd("waypaper"), { description = "Wallpaper picker" })

hl.bind(("%s + SHIFT + V"):format(mainMod), hl.dsp.exec_cmd([[cliphist list | fuzzel --dmenu --prompt "󰅌  " --width 60 | cliphist decode | wl-copy]]), { description = "Clipboard history" })
hl.bind(("%s + period"):format(mainMod), hl.dsp.exec_cmd([[rofimoji --selector fuzzel --action copy]]), { description = "Emoji picker" })

hl.bind(("%s + SHIFT + D"):format(mainMod), hl.dsp.exec_cmd([[makoctl mode -t do-not-disturb && notify-send -t 1500 "🔕 Do not disturb toggled"]]), { description = "Do not disturb" })

hl.bind(("%s + SLASH"):format(mainMod), hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/keyhelp"), { description = "Show keybindings" })
hl.bind(("%s + SHIFT + G"):format(mainMod), hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/sddm-layout"), { description = "Greeter layout" })

hl.bind(("%s + SHIFT + I"):format(mainMod), hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/theme-switch"), { description = "Theme switcher" })

hl.bind(("%s + SHIFT + P"):format(mainMod), hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/power-profile"), { description = "Cycle power profile" })

-- 10. Scratchpad / special workspace
hl.bind(("%s + grave"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch togglespecialworkspace scratchpad"), { description = "Toggle scratchpad" })
hl.bind(("%s + SHIFT + grave"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch movetoworkspacesilent special:scratchpad"), { description = "Move window to scratchpad" })

-- 11. Window/layout helpers
hl.bind(("%s + O"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch togglesplit"), { description = "Toggle split" })
hl.bind(("%s + P"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch pin"), { description = "Pin floating window" })
hl.bind(("%s + SHIFT + C"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch centerwindow"), { description = "Center floating window" })

-- 12. Monitor focus/move
hl.bind(("%s + ALT + right"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch focusmonitor +1"), { description = "Focus next monitor" })
hl.bind(("%s + ALT + left"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch focusmonitor -1"), { description = "Focus previous monitor" })
hl.bind(("%s + ALT + SHIFT + right"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch movewindow mon:+1"), { description = "Move window to next monitor" })
hl.bind(("%s + ALT + SHIFT + left"):format(mainMod), hl.dsp.exec_cmd("hyprctl dispatch movewindow mon:-1"), { description = "Move window to previous monitor" })

-- 13. Quick toggles
hl.bind(("%s + SHIFT + B"):format(mainMod), hl.dsp.exec_cmd("pkill -SIGUSR1 waybar || waybar &"), { description = "Toggle/reload Waybar" })
hl.bind(("%s + F11"):format(mainMod), hl.dsp.exec_cmd([[bash -c 'hyprctl keyword animations:enabled $(hyprctl getoption animations:enabled -j | jq -r "if .int==1 then \"false\" else \"true\" end"); hyprctl keyword decoration:blur:enabled $(hyprctl getoption decoration:blur:enabled -j | jq -r "if .int==1 then \"false\" else \"true\" end")']]), { description = "Toggle game/perf mode" })

return true

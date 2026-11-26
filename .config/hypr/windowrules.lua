-- Float rules
hl.window_rule({ match = { class = "^de\\.haeckerfelix\\.Shortwave$" },                   float = true })
hl.window_rule({ match = { class = "^Signal$" },                                          float = true })
hl.window_rule({ match = { class = "^com\\.github\\.rafostar\\.Clapper$" },               float = true })
hl.window_rule({ match = { class = "^app\\.drey\\.Warp$" },                               float = true })
hl.window_rule({ match = { class = "^net\\.davidotek\\.pupgui2$" },                       float = true })
hl.window_rule({ match = { class = "^yad$" },                                             float = true })
hl.window_rule({ match = { class = "^eog$" },                                             float = true })
hl.window_rule({ match = { class = "^io\\.github\\.alainm23\\.planify$" },                float = true })
hl.window_rule({ match = { class = "^io\\.gitlab\\.theevilskeleton\\.Upscaler$" },        float = true })
hl.window_rule({ match = { class = "^com\\.github\\.unrud\\.VideoDownloader$" },          float = true })
hl.window_rule({ match = { class = "^io\\.gitlab\\.adhami3310\\.Impression$" },           float = true })
hl.window_rule({ match = { class = "^io\\.missioncenter\\.MissionCenter$" },              float = true, size = "1290 950"})
hl.window_rule({ match = { class = "^org\\.pulseaudio\\.pavucontrol$" },                  float = true, size = "1221 619", })
hl.window_rule({ match = { title = "^File Operation Progress$" },                         float = true, size = "600 50", })
hl.window_rule({ match = { class = "^xfce-polkit$" },                                     float = true, size = "600 50", })
hl.window_rule({ match = { class = "^[Ss]team$", title = "^.*$" }, float = true })

-- Idle inhibit: see the catch-all fullscreen rule under "Misc rules"

-- Picture-in-picture
hl.window_rule({ match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture).*$" }, tag = "picture-in-picture" })
hl.window_rule({ match = { tag = "picture-in-picture" }, float = true, pin = true, keep_aspect_ratio = true, move = "73% 72%", size = "25% 25%" })

-- Opacity rules
-- hl.window_rule({ match = { class = "^firefox$" },                                             opacity = 1.0 })
-- hl.window_rule({ match = { class = "^code-oss$" },                                             opacity = 1.0 })
-- hl.window_rule({ match = { class = "^[Cc]ode$" },                                              opacity = 1.0 })
-- hl.window_rule({ match = { class = "^code-url-handler$" },                                     opacity = 1.0 })
-- hl.window_rule({ match = { class = "^code-insiders-url-handler$" },                            opacity = 1.0 })
-- Terminals: let app/compositor transparency show through (kitty uses its own background_opacity)
-- hl.window_rule({ match = { class = "^org\\.kde\\.dolphin$" },                                  opacity = 1.0 })
-- hl.window_rule({ match = { class = "^org\\.kde\\.ark$" },                                      opacity = 1.0 })
-- hl.window_rule({ match = { class = "^nwg-look$" },                                             opacity = 1.0 })
-- hl.window_rule({ match = { class = "^qt5ct$" },                                                opacity = 1.0 })
-- hl.window_rule({ match = { class = "^qt6ct$" },                                                opacity = 1.0 })
-- hl.window_rule({ match = { class = "^extsource$" },                                            opacity = 1.0 })
-- hl.window_rule({ match = { class = "^kvantummanager$" },                                       opacity = 1.0 })
-- hl.window_rule({ match = { class = "^org\\.pulseaudio\\.pavucontrol$" },                       opacity = 1.0 })
-- hl.window_rule({ match = { class = "^blueman-manager$" },                                      opacity = 1.0 })
-- hl.window_rule({ match = { class = "^nm-applet$" },                                            opacity = 1.0 })
-- hl.window_rule({ match = { class = "^nm-connection-editor$" },                                 opacity = 1.0 })
-- hl.window_rule({ match = { class = "^org\\.kde\\.polkit-kde-authentication-agent-1$" },        opacity = 1.0 })
-- hl.window_rule({ match = { class = "^polkit-gnome-authentication-agent-1$" },                  opacity = 1.0 })
-- hl.window_rule({ match = { class = "^org\\.freedesktop\\.impl\\.portal\\.desktop\\.gtk$" },    opacity = 1.0 })
-- hl.window_rule({ match = { class = "^org\\.freedesktop\\.impl\\.portal\\.desktop\\.hyprland$" }, opacity = 1.0 })
-- hl.window_rule({ match = { class = "^[Ss]team$" },                                             opacity = 1.0 })
-- hl.window_rule({ match = { class = "^[Ss]potify$" },                                           opacity = 1.0 })
-- hl.window_rule({ match = { initial_title = "^Spotify Free$" },                                 opacity = 1.0 })
-- hl.window_rule({ match = { initial_title = "^Spotify Premium$" },                              opacity = 1.0 })
hl.window_rule({ match = { class = "^com\\.github\\.rafostar\\.Clapper$" },                    opacity = 1.0 })
-- hl.window_rule({ match = { class = "^com\\.github\\.tchx84\\.Flatseal$" },                     opacity = 1.0 })
-- hl.window_rule({ match = { class = "^hu\\.kramo\\.Cartridges$" },                              opacity = 1.0 })
hl.window_rule({ match = { class = "^com\\.obsproject\\.Studio$" },                            opacity = 1.0 })
hl.window_rule({ match = { class = "^gnome-boxes$" },                                          opacity = 1.0 })
-- hl.window_rule({ match = { class = "^vesktop$" },                                              opacity = 1.0 })
-- hl.window_rule({ match = { class = "^discord$" },                                              opacity = 1.0 })
-- hl.window_rule({ match = { class = "^WebCord$" },                                              opacity = 1.0 })
-- hl.window_rule({ match = { class = "^ArmCord$" },                                              opacity = 1.0 })
-- hl.window_rule({ match = { class = "^app\\.drey\\.Warp$" },                                    opacity = 1.0 })
-- hl.window_rule({ match = { class = "^net\\.davidotek\\.pupgui2$" },                            opacity = 1.0 })
-- hl.window_rule({ match = { class = "^yad$" },                                                  opacity = 1.0 })
-- hl.window_rule({ match = { class = "^Signal$" },                                               opacity = 1.0 })
-- hl.window_rule({ match = { class = "^io\\.github\\.alainm23\\.planify$" },                     opacity = 1.0 })
-- hl.window_rule({ match = { class = "^io\\.gitlab\\.theevilskeleton\\.Upscaler$" },             opacity = 1.0 })
-- hl.window_rule({ match = { class = "^com\\.github\\.unrud\\.VideoDownloader$" },               opacity = 1.0 })
-- hl.window_rule({ match = { class = "^io\\.gitlab\\.adhami3310\\.Impression$" },                opacity = 1.0 })
-- hl.window_rule({ match = { class = "^io\\.missioncenter\\.MissionCenter$" },                   opacity = 1.0 })
-- hl.window_rule({ match = { class = "^io\\.github\\.flattool\\.Warehouse$" },                   opacity = 1.0 })

-- File pickers / portals: float and center
hl.window_rule({ match = { title = "(?i)^(open file|open files|save file|save as|open folder|select a file|choose files?|file upload).*" }, float = true, center = true, size = "60% 65%" })
hl.window_rule({ match = { class = "(?i)^(xdg-desktop-portal-gtk|xdg-desktop-portal-gnome)$" }, float = true, center = true })

-- Media / utility windows
hl.window_rule({ match = { class = "(?i)^mpv$" }, float = true, center = true, size = "60% 60%" })
hl.window_rule({ match = { class = "(?i)^(nm-connection-editor|blueman-manager|org.gnome.seahorse.application)$" }, float = true, center = true })

-- Misc rules
hl.window_rule({ match = { class = "^.*jetbrains.*$", title = "^win[0-9]+$" }, no_initial_focus = true })
-- Ghidra (Java/Swing): menus and tooltips are untitled "winN" windows; don't let them steal focus.
hl.window_rule({ match = { class = "^ghidra-.*$", title = "^win[0-9]+$" }, no_initial_focus = true })

-- Never dim/lock/sleep while any window is fullscreen
hl.window_rule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })

-- Ignore maximize requests from apps; tiling decides window size
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
-- hl.window_rule({ match = { class = "(?i)^(vscodium|codium)$" }, opacity = 1.0 })

-- Waybar popups (weather, system update, btop)
hl.window_rule({ match = { class = "^floating-(weather|update)$" }, float = true, center = true, size = "60% 70%" })
hl.window_rule({ match = { class = "^btop$" }, float = true, center = true, size = "70% 75%" })

-- Editors and browser: solid when focused (readable text), glassy when not
hl.window_rule({ match = { class = "(?i)^(firefox|code|code-oss|code-url-handler|vscodium|codium)$" }, opacity = "1.0 0.85" })

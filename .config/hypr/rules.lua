-- Community-style window rules (r/unixporn favourites)

-- File pickers and dialogs: float, centered
hl.window_rule({ match = { title = "(?i)^(open file|open files|save file|save as|open folder|select a file|choose files?|file upload).*" }, float = true, center = true, size = "60% 65%" })
hl.window_rule({ match = { class = "(?i)^(xdg-desktop-portal-gtk|xdg-desktop-portal-gnome)$" }, float = true, center = true })

-- Picture-in-picture: float, pinned on every workspace, keep shape
hl.window_rule({ match = { title = "(?i)^picture[- ]in[- ]picture$" }, float = true, pin = true, keep_aspect_ratio = true, size = "30% 30%" })

-- mpv: neat centered window
hl.window_rule({ match = { class = "(?i)^mpv$" }, float = true, center = true, size = "60% 60%" })

-- Auth prompts, settings and progress windows
hl.window_rule({ match = { class = "(?i)^(polkit-gnome-authentication-agent-1|nm-connection-editor|blueman-manager|org.gnome.seahorse.application)$" }, float = true, center = true })
hl.window_rule({ match = { title = "(?i)^file operation progress$" }, float = true, center = true })

-- Steam: main window tiles, side windows float
hl.window_rule({ match = { class = "(?i)^steam$", title = "^(?!Steam$).*" }, float = true })

-- Apps on their own workspaces
hl.window_rule({ match = { class = "(?i)^(brave-origin|brave-origin-browser|brave-browser)$" }, workspace = "2" })
hl.window_rule({ match = { class = "(?i)^(vscodium|codium)$" }, workspace = "3" })
hl.window_rule({ match = { class = "(?i)^(slack|karere.*|obsidian)$" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "(?i)^steam$" }, workspace = "5 silent" })

-- Never dim, lock or sleep while something is fullscreen
hl.window_rule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })

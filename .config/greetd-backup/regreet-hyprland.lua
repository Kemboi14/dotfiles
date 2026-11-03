hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.config({
  animations = { enabled = false },
  decoration = {
    blur = { enabled = false },
    shadow = { enabled = false },
  },
  input = {
    kb_layout = "us",
    numlock_by_default = false,
    repeat_delay = 250,
    repeat_rate = 35,
    touchpad = {
      tap_to_click = true,
      natural_scroll = true,
      disable_while_typing = true,
      scroll_factor = 0.3,
    },
  },
  misc = {
    disable_autoreload = true,
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
  },
})

local cursor_theme = "Adwaita"
local cursor_size = "24"
hl.env("HYPRCURSOR_THEME", cursor_theme)
hl.env("HYPRCURSOR_SIZE", cursor_size)
hl.env("XCURSOR_THEME", cursor_theme)
hl.env("XCURSOR_SIZE", cursor_size)

hl.on("hyprland.start", function()
  hl.exec_cmd("regreet --style /var/lib/greeter-theme/regreet.css; hyprctl dispatch 'hl.dsp.exit()'")
end)

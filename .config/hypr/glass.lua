-- Frosted glass: blur, shadows, rounding
hl.config({
    decoration = {
        rounding = 14,
        active_opacity = 1.0,
        inactive_opacity = 0.95,
        blur = {
            enabled = true,
            size = 8,
            passes = 4,
            new_optimizations = true,
            xray = false,
            noise = 0.02,
            vibrancy = 0.2,
            vibrancy_darkness = 0.2,
            contrast = 0.95,
            brightness = 0.9,
            popups = true,
        },
        shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            color = "rgba(00000066)",
        },
    },
})

-- Blur behind the bar, notifications, menus and OSD
hl.layer_rule({ match = { namespace = "^(waybar|notifications|launcher|swayosd)$" }, blur = true, ignore_alpha = 0.3 })

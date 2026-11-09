hl.config({
    input = {
        kb_layout = "us",
        kb_options = "",
        numlock_by_default = true,
        repeat_delay = 250,
        repeat_rate = 35,
        accel_profile = "adaptive",
        sensitivity = 0.5,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 0.5,
        },
        special_fallthrough = true,
        follow_mouse = 1,
    },
})

-- Three-finger swipe left/right to change workspace
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

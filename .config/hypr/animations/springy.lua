-- Springy preset: windows pop with a gentle overshoot, workspaces glide elastically
hl.curve("springy",  { type = "spring", mass = 1, stiffness = 200, dampening = 16 })
hl.curve("elastic",  { type = "spring", mass = 1, stiffness = 150, dampening = 18 })
hl.curve("snappy",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("smooth",   { type = "bezier", points = { {0.25, 1}, {0.5, 1} } })
hl.curve("linear",   { type = "bezier", points = { {0, 0}, {1, 1} } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "windows",       enabled = true, speed = 5,   spring = "springy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 5,   spring = "springy", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 3,   bezier = "snappy",  style = "popin 80%" })
hl.animation({ leaf = "windowsMove",   enabled = true, speed = 5,   spring = "springy" })
hl.animation({ leaf = "border",        enabled = true, speed = 6,   bezier = "smooth" })
hl.animation({ leaf = "fade",          enabled = true, speed = 4,   bezier = "smooth" })
hl.animation({ leaf = "layers",        enabled = true, speed = 4,   spring = "springy", style = "slide" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 5,   spring = "elastic", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, spring = "elastic", style = "slidevert" })

-- Slowly rotating gradient border on the focused window
hl.animation({ leaf = "borderangle", enabled = true, speed = 80, bezier = "linear", style = "loop" })

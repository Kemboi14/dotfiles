-- Media & Hardware Keys
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                             { locked = true, description = "Play or pause" })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                   { locked = true, description = "Next track" })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                               { locked = true, description = "Previous track" })
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume lower"),        { locked = true, description = "Volume down" })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),       { locked = true, description = "Mute output" })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),     { locked = true, description = "Mute microphone" })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness raise"),                    { locked = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"),                    { locked = true, description = "Brightness down" })
return true

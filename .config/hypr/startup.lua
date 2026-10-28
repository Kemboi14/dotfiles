local env = {
    "XDG_CURRENT_DESKTOP,Hyprland",
    "XDG_SESSION_TYPE,wayland",
    "QT_QPA_PLATFORMTHEME,qtengine",
    "QT_AUTO_SCREEN_SCALE_FACTOR,1",
    "QT_WAYLAND_DISABLE_WINDOWDECORATION,1",
    "ELECTRON_OZONE_PLATFORM_HINT,wayland",
}


local exec_once = {
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1",
    "gnome-keyring-daemon --start --components=secrets",
    "systemctl --user start --ignore-dependencies xdg-desktop-portal-hyprland.service xdg-desktop-portal.service",
    "waybar",
    "wl-paste --watch cliphist store",
    "swayosd-server",
    "mako",
    "hypridle",
    "/home/nick/.local/bin/raw-theme",
    "wl-clip-persist --clipboard regular",
}



for _, item in ipairs(env) do
    local key, value = item:match("^([^,]+),(.+)$")
    if key and value then
        hl.env(key, value)
    end
end


hl.on("hyprland.start", function()
    for _, cmd in ipairs(exec_once) do
        hl.exec_cmd(cmd)
    end

   -- Run one final reload after startup commands have had time to initialize.
end)

return true

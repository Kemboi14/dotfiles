-- Hyprland colours from Caelestia (follows the wallpaper scheme)
local fallback = {
    primary = "b4c7ed",
    secondary = "bdc7dc",
    surface = "0c0e12",
    onSurface = "e3e5ef",
    onSecondary = "374052",
    error = "fa746f",
    onError = "490006",
}

local function load_scheme()
    package.loaded["scheme.current"] = nil
    local ok, scheme = pcall(require, "scheme.current")
    if ok and type(scheme) == "table" then
        return scheme
    end
    return fallback
end

local function apply_theme()
    local c = load_scheme()
    local function col(name)
        return "rgb(" .. (c[name] or fallback[name]) .. ")"
    end

    hl.config({
        general = {
            col = {
                active_border = col("primary"),
                inactive_border = col("surface"),
            },
        },
        group = {
            col = {
                border_active = col("secondary"),
                border_inactive = col("surface"),
                border_locked_active = col("error"),
                border_locked_inactive = col("surface"),
            },
            groupbar = {
                col = {
                    active = col("secondary"),
                    inactive = col("surface"),
                    locked_active = col("error"),
                    locked_inactive = col("surface"),
                },
                text_color = col("onSecondary"),
                text_color_inactive = col("onSurface"),
                text_color_locked_active = col("onError"),
                text_color_locked_inactive = col("onSurface"),
            },
        },
    })
end

return { apply_theme = apply_theme }

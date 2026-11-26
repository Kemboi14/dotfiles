-- Cursor theme is read at login from the same files nwg-look (or the
-- `cursor` fish command) writes, so there is one source of truth.
local HOME = os.getenv("HOME") or ""
local DEFAULT_THEME = "Adwaita"
local DEFAULT_SIZE = "24"

local function escape(s)
    return (s:gsub("[%-%.%+%[%]%(%)%$%^%%%?%*]", "%%%0"))
end

local function read_key(path, key)
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local pattern = "^%s*" .. escape(key) .. "%s*=%s*(.-)%s*$"
    for line in f:lines() do
        local v = line:match(pattern)
        if v and v ~= "" then
            f:close()
            return v
        end
    end
    f:close()
    return nil
end

local function theme_exists(name)
    for _, dir in ipairs({ HOME .. "/.icons/", HOME .. "/.local/share/icons/", "/usr/share/icons/" }) do
        local f = io.open(dir .. name .. "/cursors/left_ptr", "r")
        if f then
            f:close()
            return true
        end
    end
    return false
end

local gtk_ini = HOME .. "/.config/gtk-3.0/settings.ini"

local theme = read_key(HOME .. "/.icons/default/index.theme", "Inherits")
    or read_key(gtk_ini, "gtk-cursor-theme-name")
if theme then
    theme = theme:match("^[^,;]+")
end
if not theme or not theme_exists(theme) then
    theme = DEFAULT_THEME
end

local size = read_key(gtk_ini, "gtk-cursor-theme-size")
if not (size and size:match("^%d+$")) then
    size = DEFAULT_SIZE
end

local env = {
    { "HYPRCURSOR_THEME", theme },
    { "HYPRCURSOR_SIZE", size },
    { "XCURSOR_THEME", theme },
    { "XCURSOR_SIZE", size },
    { "QT_CURSOR_THEME", theme },
    { "QT_CURSOR_SIZE", size },
}

for _, kv in ipairs(env) do
    hl.env(kv[1], kv[2])
end

-- Decoration (rounding, opacity, blur, shadow) lives in glass.lua.
hl.config({
    general = {
        gaps_in = 4,
        gaps_out = { top = 4, right = 8, bottom = 8, left = 8 },
        border_size = 1,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

})

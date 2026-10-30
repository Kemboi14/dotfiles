-- Colours from ~/.cache/wal/colors.json (written by raw-theme on every wallpaper change).
-- Applied through mini.base16 and re-applied live when the file changes.
local path = vim.fn.expand("~/.cache/wal/colors.json")

local function rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function blend(a, b, t)
  local ar, ag, ab = rgb(a)
  local br, bg, bb = rgb(b)
  local function mix(x, y)
    return math.floor(x + (y - x) * t + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(ar, br), mix(ag, bg), mix(ab, bb))
end

local function read()
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local ok, data = pcall(vim.json.decode, f:read("*a"))
  f:close()
  if ok and type(data) == "table" and type(data.colors) == "table" then
    return data
  end
  return nil
end

local function apply()
  local data = read()
  if not data then
    vim.cmd.colorscheme("habamax")
    return
  end
  local c = data.colors
  local sp = data.special or {}
  local bg = sp.background or c.color0
  local fg = sp.foreground or c.color15
  local ok, err = pcall(function()
    require("mini.base16").setup({
      palette = {
        base00 = bg,
        base01 = blend(bg, fg, 0.06),
        base02 = blend(bg, fg, 0.14),
        base03 = blend(bg, fg, 0.40),
        base04 = blend(bg, fg, 0.65),
        base05 = fg,
        base06 = blend(fg, c.color15, 0.5),
        base07 = c.color15,
        base08 = c.color1,
        base09 = c.color9,
        base0A = c.color3,
        base0B = c.color2,
        base0C = c.color6,
        base0D = c.color4,
        base0E = c.color5,
        base0F = c.color13,
      },
      use_cterm = false,
    })
  end)
  if not ok then
    vim.notify("wal colours failed: " .. tostring(err), vim.log.levels.WARN)
    vim.cmd.colorscheme("habamax")
    return
  end
  vim.g.colors_name = "wal"
  vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "wal", modeline = false })
end

local function watch()
  local w = vim.uv.new_fs_event()
  if not w then
    return
  end
  local pending = false
  w:start(path, {}, function()
    if pending then
      return
    end
    pending = true
    vim.defer_fn(function()
      pending = false
      apply()
    end, 300)
  end)
end

return {
  {
    "echasnovski/mini.base16",
    lazy = false,
    priority = 1000,
    config = function()
      watch()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = apply,
    },
  },
}

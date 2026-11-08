-- Colorscheme generated from the Caelestia wallpaper scheme.
local path = vim.fn.expand("~/.local/state/caelestia/scheme.json")
local mtime = 0

local function palette()
  local ok, data = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
  end)
  if not ok or type(data) ~= "table" or type(data.colours) ~= "table" then
    return nil
  end
  local c = data.colours
  local function h(key, fallback)
    local v = c[key] or fallback
    if not v then
      return nil
    end
    return "#" .. (v:gsub("^#", ""))
  end
  return {
    base00 = h("surface"),
    base01 = h("surfaceContainer"),
    base02 = h("surfaceContainerHigh"),
    base03 = h("outline"),
    base04 = h("onSurfaceVariant"),
    base05 = h("onSurface"),
    base06 = h("primaryFixed", c.onSurface),
    base07 = h("onBackground", c.onSurface),
    base08 = h("error"),
    base09 = h("tertiary"),
    base0A = h("secondary"),
    base0B = h("success", c.primary),
    base0C = h("term6", c.secondary),
    base0D = h("primary"),
    base0E = h("term5", c.tertiary),
    base0F = h("outlineVariant"),
  }
end

local function apply()
  local p = palette()
  if not p then
    vim.notify("scheme.json not readable; keeping current colors", vim.log.levels.WARN)
    return
  end
  require("mini.base16").setup({ palette = p, use_cterm = true })
  vim.g.colors_name = "caelestia"
  local st = vim.uv.fs_stat(path)
  mtime = st and st.mtime.sec or 0
end

return {
  {
    "echasnovski/mini.base16",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_user_command("SchemeReload", apply, {})
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          local st = vim.uv.fs_stat(path)
          if st and st.mtime.sec ~= mtime then
            apply()
          end
        end,
      })
    end,
  },
  { "LazyVim/LazyVim", opts = { colorscheme = apply } },
}

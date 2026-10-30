-- VSCodium-style layout for LazyVim: tabs, breadcrumbs, docked explorer, sticky scroll.
return {
  -- Breadcrumbs above each editor (path > class > function), clickable like VS Code
  {
    "Bekaboo/dropbar.nvim",
    event = "LazyFile",
    opts = {},
  },

  -- Tabs always visible, with an EXPLORER header over the file tree
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
        separator_style = "thin",
        offsets = {
          { filetype = "snacks_layout_box", text = "EXPLORER", text_align = "left", separator = true },
        },
      },
    },
  },

  -- File explorer docked on the left, 32 columns, showing dotfiles and git status
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { replace_netrw = true },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            layout = { layout = { position = "left", width = 32 } },
          },
        },
      },
    },
  },

  -- Sticky scroll: keep the current function/class header pinned at the top
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = { max_lines = 3, mode = "cursor" },
  },
}

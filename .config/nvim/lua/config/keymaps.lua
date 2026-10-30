-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- VS Code muscle memory
vim.keymap.set("n", "<C-p>", function() Snacks.picker.files() end, { desc = "Find file (Ctrl+P)" })
vim.keymap.set({ "n", "i" }, "<C-b>", function() Snacks.explorer() end, { desc = "Toggle explorer (Ctrl+B)" })
vim.keymap.set({ "n", "t" }, "<C-`>", function() Snacks.terminal() end, { desc = "Toggle terminal (Ctrl+`)" })
vim.keymap.set("n", "<C-A-b>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude (Ctrl+Alt+B)" })

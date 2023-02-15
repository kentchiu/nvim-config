-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape" })

-- To use CTRL+{h,j,k,l} to navigate windows from terminal in any mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go To Left Window In Terminal" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go To Bottom Window In Terminal" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go Top Up Window In Terminal" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go Right Up Window In Terminal" })

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { noremap = true, desc = "Save window" })

-- Unmap mappings used by tmux plugin
-- TODO(vintharas): There's likely a better way to do this.
-- vim.keymap.del("n", "<C-h>")
-- vim.keymap.del("n", "<C-j>")
-- vim.keymap.del("n", "<C-k>")
-- vim.keymap.del("n", "<C-l>")
-- vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
-- vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
-- vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
-- vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

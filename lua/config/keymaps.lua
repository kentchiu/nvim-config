-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

-- To use CTRL+{h,j,k,l} to navigate windows from terminal in any mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go To Left Window In Terminal" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go To Bottom Window In Terminal" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go Top Up Window In Terminal" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go Right Up Window In Terminal" })

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd>wa<cr>", { noremap = true, desc = "Save window" })

vim.keymap.set("n", "<leader>ut", "<cmd>TSPlaygroundToggle<cr>", { desc = "Toggle TreeSitter Playground" })

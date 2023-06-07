-----------------------
--- Playground <leader>p + [key]
-----------------------

-- source playground
vim.keymap.set("n", "<leader>pp", "<cmd>source ~/.config/nvim/lua/custom/config/playground.lua<cr>",
{ desc = "Reload Playgroud" })

-- print("Playground is sourced")

-- window
vim.keymap.set({ "n", "v", "x" }, "<leader>wc", "<cmd>cclose<cr><cmd>lclose<cr>", { desc = "Close error windows" })
-- diagnostics
vim.keymap.set("n", "<leader>cx", function() vim.diagnostic.open_float({ border = "rounded" }) end,
{ desc = "View Diagnostics In Float Window" })
-- vim.keymap.set("n", "<cr>", "ciw", { desc="Enter to change inside word"})
-- The line beneath this is called `modeline`. See `:help modeline`
--

--[[ -- Yank into system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y') -- yank motion
vim.keymap.set({'n', 'v'}, '<leader>Y', '"+Y') -- yank line

-- Delete into system clipboard
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d') -- delete motion
vim.keymap.set({'n', 'v'}, '<leader>D', '"+D') -- delete line

-- Paste from system clipboard
vim.keymap.set('n', '<leader>p', '"+p')  -- paste after cursor
vim.keymap.set('n', '<leader>P', '"+P')  -- paste before cursor ]]



-- vim: ts=2 sts=2 sw=2 et

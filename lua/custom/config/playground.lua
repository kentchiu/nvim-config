-----------------------
--- Playground <leader>p + [key]
-----------------------

-- source playground
vim.keymap.set("n", "<leader>pp", "<cmd>source ~/.config/nvim/lua/custom/config/playground.lua<cr>", {desc="Reload Playgroud"})

-- print("Playground is sourced")

vim.keymap.set({"n", "v", "x"}, "<leader>wc", "<cmd>cclose<cr><cmd>lclose<cr>", {desc="Close error windows"})
-- vim.keymap.set("n", "<leader>wC", "<cmd>cclose<cr>")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

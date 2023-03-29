-- [[ Basic Keymaps ]]
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- better up/down
-- Remap for dealing with word wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })



-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
-- if Util.has("bufferline.nvim") then
--   vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--   vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- else
--

vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- end
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })


-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save file
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- if not Util.has("trouble.nvim") then
--   map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
--   map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
-- end

-- toggle options
--
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- map("n", "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
-- map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
--
vim.keymap.set("n", "<leader>ut", "<cmd>TSPlaygroundToggle<cr>", { desc = "Toggle TS playground" })
vim.keymap.set("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle Spelling" })
vim.keymap.set("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle Word Wrap" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set("n", "<leader>ur", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>",
  { desc = "Redraw / clear hlsearch / diff update" })

-- highlights under cursor
if vim.fn.has "nvim-0.9.0" == 1 then
  vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
--

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<A-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<A-h>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<A-j>", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<A-k>", "<cmd>tablast<cr>", { desc = "Last Tab" })

-- misc

-- c-v conflict with windows paste shortcut
vim.keymap.set("n", "<leader>cc", "<c-v>", { desc = "Column Mode" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- Search word under cursor
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- create folder
vim.keymap.set("n", "m", "zf%", { desc = "Create Fold", remap = true })

-- neo-test
-- vim.keymap.set("n", "<leader>tm", function() require("neotest").run.run() end, { desc = "Run Current Menthod Test" })
-- vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run Current File Test" })
-- vim.keymap.set("n", "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, { desc = "Run All Tests" })
-- vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Test Summary" })


-- git 
--[[
-- GitSigns
if is_available "gitsigns.nvim" then
  maps.n["<leader>g"] = sections.g
  maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
  maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
  maps.n["<leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
  maps.n["<leader>gp"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" }
  maps.n["<leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
  maps.n["<leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
  maps.n["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
  maps.n["<leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
  maps.n["<leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
  maps.n["<leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }
end
]]




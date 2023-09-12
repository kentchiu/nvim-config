-----------------------
--- Playground <leader>p + [key]
-----------------------

-- source playground
vim.keymap.set("n", "<leader>pp", "<cmd>source ~/.config/nvim/lua/custom/config/playground.lua<cr>",
  { desc = "Reload Playgroud" })

-- print("Playground is sourced")

-- window
-- vim.keymap.set({ "n", "v", "x" }, "<leader>wc", "<cmd>cclose<cr><cmd>lclose<cr><cmd>tabclose<cr>",
--   { desc = "Close error windows" })
-- diagnostics
-- vim.keymap.set("n", "<leader>cx", function() vim.diagnostic.open_float({ border = "rounded" }) end,
--   { desc = "View Diagnostics In Float Window" })
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


--   {
--     "<leader>rr",
--     function()
--       require("rest-nvim").run()
--     end,
--     desc = "RestNvimRun",
--   },

-- vim.api.nvim_create_autocmd('BufEnter', {
--   desc = 'keymap only on markdown (obsidian)',
--
--   group = vim.api.nvim_create_augroup('obsidian_actions', { clear = true }),
--   callback = function(opts)
--     if vim.bo[opts.buf].filetype == 'markdown' then
--       vim.api.nvim_buf_set_keymap(0 , "n", "<leader>pg", "<cmd>ObsidianFollowLink<cr>", { desc = "ObsidianFollowLink" })
--     end
--   end,
-- })


-- Treesitter automatic Python format strings
vim.api.nvim_create_augroup("py-fstring", { clear = true })
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = { "*.py" },
  group = "py-fstring",
  --- @param opts AutoCmdCallbackOpts
  --- @return nil
  callback = function(opts)
    -- Only run if f-string escape character is typed
    if vim.v.char ~= "{" then return end

    -- Get node and return early if not in a string
    local node = vim.treesitter.get_node()

    if not node then return end
    if node:type() ~= "string" then node = node:parent() end
    if not node or node:type() ~= "string" then return end

    vim.print(node:type())
    local row, col, _, _ = vim.treesitter.get_node_range(node)

    -- Return early if string is already a format string
    local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col, row, col + 1, {})[1]
    vim.print("row " .. row .. " col " .. col)
    vim.print("char: '" .. first_char .. "'")
    if first_char == "f" then return end

    -- Otherwise, make the string a format string
    vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<Esc>`'la")
  end,
})

vim.api.nvim_create_autocmd("BufHidden", {
  desc = "Delete [No Name] buffers",
  callback = function(event)
    print("enter no name buffer callback")
    if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
      print("Delete No Name Buffer")
      vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
    end
  end,
})

-- paste after cursor
-- vim: ts=2 sts=2 sw=2 et

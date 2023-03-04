local Util = require("lazyvim.util")
return {
  { "nvim-treesitter/playground" },
  { "chaoren/vim-wordmotion" },
  -- enabled git sign column
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  -- overwrite telesope default keymap
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- change a keymap
      {
        "<leader>ss",
        -- require("lazyvim.util").telescope("lsp_document_symbols", {}),
        Util.telescope("lsp_document_symbols", {}),
        desc = "Goto Symbol",
      },
    },
  },
}

return {
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      --
      -- Some of lsp relative mappings is defined in LSP on_attach function
      --
      { "<leader>,",       "<cmd>Telescope buffers show_all_buffers=true<cr>",   desc = "Switch Buffer" },
      {
        "<leader>/",
        require("telescope.builtin").live_grep,
        desc =
        "Find in Files (Grep)"
      },
      { "<leader>:",       "<cmd>Telescope command_history<cr>",                 desc = "Command History" },
      { "<leader><space>", require("telescope.builtin").find_files,              desc = "Find Recent Used Files" },
      -- find
      { "<leader>fb",      "<cmd>Telescope buffers<cr>",                         desc = "Buffers" },
      { "<leader>ff",      require("telescope.builtin").find_files,              desc = "Find Files" },
      { "<leader>sf",      require("telescope.builtin").find_files,              desc = "Find Files" },
      { "<leader>fr",      require("telescope.builtin").oldfiles,                desc = "Recent" },
      -- git
      { "<leader>gC",      "<cmd>Telescope git_commits<cr>",                     desc = "Commits" },
      -- {
      --   "<leader>gC",
      --   "<cmd>Telescope git_bcommits<cr>",
      --   desc =
      --   "Diff Current Buffer"
      -- },
      { "<leader>gs",      "<cmd>Telescope git_status<cr>",                      desc = "Git Status" },
      { "<leader>gB",      "<cmd>Telescope git_branches<cr>",                    desc = "Branches" },
      -- search
      { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                    desc = "Auto Commands" },
      { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",       desc = "Buffer" },
      { "<leader>sc",      "<cmd>Telescope command_history<cr>",                 desc = "Command History" },
      { "<leader>sC",      "<cmd>Telescope commands<cr>",                        desc = "Commands" },
      { "<leader>sE",      "<cmd>Telescope symbols<cr>",                         desc = "Emoji" },
      -- { "<leader>sg",      require("telescope.builtin").live_grep,               desc = "Find in Files (Grep)" },
      --[[
  maps.n["<leader>fW"] = {
    function()
      require("telescope.builtin").live_grep {
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
      }
    end,
    desc = "Find words in all files",
  }
      ]]
      { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                       desc = "Help Pages" },
      { "<leader>sH",      "<cmd>Telescope highlights<cr>",                      desc = "Search Highlight Groups" },
      { "<leader>sj",      "<cmd>Telescope jumplist<cr>",                        desc = "Jump List" },
      { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                         desc = "Key Maps" },
      { "<leader>sl",      "<cmd>Telescope loclist<cr>",                         desc = "Current window's Location List" },
      { "<leader>sM",      "<cmd>Telescope man_pages<cr>",                       desc = "Man Pages" },
      { "<leader>sm",      "<cmd>Telescope marks<cr>",                           desc = "Jump to Mark" },
      { "<leader>so",      "<cmd>Telescope vim_options<cr>",                     desc = "Options" },
      { "<leader>sq",      "<cmd>Telescope quickfix<cr>",                        desc = "Quickfix" },
      { "<leader>sQ",      "<cmd>Telescope quickfixhistory<cr>",                 desc = "Quickfix History" },
      { "<leader>ss",      "<cmd>Telescope resume<cr>",                          desc = "Resume" },
      { "<leader>s<CR>",   function() require("telescope.builtin").resume() end, desc = "Resume previous search" },
      -- maps.n["<leader>f<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
      { "<leader>st",      "<cmd>Telescope treesitter<cr>",                      desc = "Treesitter" },
      { "<leader>sw",      require("telescope.builtin").grep_string,             desc = "Word" },
      { "<leader>sx",      require("telescope.builtin").diagnostics,             desc = "Diagnostics" },
      {
        "<leader>sT",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Theme"
      },
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo" },
      -- { "<leader>ss", require("telescope.builtin").lsp_document_symbols, desc = "Goto Symbol", },
      -- {
      --   "<leader>sS",
      --   require("telescope.builtin").lsp_workspace_symbols,
      --   {
      --     symbols = {
      --       "Class",
      --       "Function",
      --       "Method",
      --       "Constructor",
      --       "Interface",
      --       "Module",
      --       "Struct",
      --       "Trait",
      --       "Field",
      --       "Property",
      --     }
      --   },
      --   desc = "Goto Symbol (Workspace)",
      -- },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
          i = {
            -- ["<c-t>"] = function(...)
            --   return require("trouble.providers.telescope").open_with_trouble(...)
            -- end,
            --     ["<a-t>"] = function(...)
            --   return require("trouble.providers.telescope").open_selected_with_trouble(...)
            -- end,
            ["<a-i>"] = function()
              require("telescope.builtin").find_files({ no_ignore = true })
            end,
            ["<a-h>"] = function()
              require("telescope.builtin").find_files({ hidden = true })
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
            -- use_delta = true,
            -- layout_strategy = "vertical",
            -- layout_config = {
            --   preview_height = 0.8,
            -- },
            -- use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
            -- side_by_side = false,
            -- diff_context_lines = vim.o.scrolloff,
            -- entry_format = "state #$ID, $STAT, $TIME",
            -- mappings = {
            --   i = {
            --     -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
            --     -- you want to replicate these defaults and use the following actions. This means
            --     -- installing as a dependency of telescope in it's `requirements` and loading this
            --     -- extension from there instead of having the separate plugin definition as outlined
            --     -- above.
            --     ["<cr>"] = require("telescope-undo.actions").yank_additions,
            --     ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            --     ["<C-cr>"] = require("telescope-undo.actions").restore,
            --   },
            -- },
          },
        },
      })
      require("telescope").load_extension("undo")
      require("telescope").load_extension("live_grep_args")
      vim.keymap.set("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },

  { "nvim-telescope/telescope-symbols.nvim" },
}

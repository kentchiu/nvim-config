-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
  checker = { enabled = true }, -- automatically check for plugin updates
  -- NOTE: First, some plugins that don"t require any configuration

  -- Git related plugins
  -- "tpope/vim-fugitive",
  -- "tpope/vim-rhubarb",
  --
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",         -- Snippet Engine
      "saadparwaiz1/cmp_luasnip", -- luasnip complete source
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  -- {
  --   -- Add indentation guides even on blank lines
  --   "lukas-reineke/indent-blankline.nvim",
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   opts = {
  --     -- char = "┊",
  --     show_trailing_blankline_indent = false,
  --   },
  -- },
  -- "gc" to comment visual regions/lines
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = function()
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  -- Fuzzy Finder (files, lsp, etc)
  { "nvim-telescope/telescope.nvim",              version = "*", dependencies = { "nvim-lua/plenary.nvim" } },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  -- {
  --   -- Highlight, edit, and navigate code
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter-textobjects",
  --   },
  --   config = function()
  --     pcall(require("nvim-treesitter.install").update({ with_sync = true }))
  --   end,
  -- },
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I"ve included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require "kickstart.plugins.autoformat",
  -- require "kickstart.plugins.debug",

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you"re interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = "custom.plugins" },
}, {})

-- load config
require("custom.config")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
-- vim.keymap.set("n", "<leader>s/", function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = "Fuzzily search in current buffer" })
--

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- require("nvim-treesitter.configs").setup({
--   -- Add languages to be installed here that you want installed for treesitter
--   -- ensure_installed = {
--   -- 	"bash",
--   -- 	"comment",
--   -- 	"css",
--   -- 	"diff",
--   -- 	"dockerfile",
--   -- 	"dot",
--   -- 	"html",
--   -- 	"http",
--   -- 	"javascript",
--   -- 	"json",
--   -- 	"jsdoc",
--   -- 	"json5",
--   -- 	"jq",
--   -- 	"lua",
--   -- 	"make",
--   -- 	"markdown",
--   -- 	"markdown_inline",
--   -- 	"python",
--   -- 	"regex",
--   -- 	"scss",
--   -- 	"sql",
--   -- 	"toml",
--   -- 	"tsx",
--   -- 	"typescript",
--   -- 	"vim",
--   -- 	"vimdoc",
--   -- 	"yaml",
--   -- },
--   -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
--   ensure_installed = "all",
--   auto_install = false,
--   highlight = { enable = true },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = "<c-space>",
--       node_incremental = "<c-space>",
--       scope_incremental = "<c-s>",
--       node_decremental = "<M-space>",
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ["aa"] = "@parameter.outer",
--         ["ia"] = "@parameter.inner",
--         ["af"] = "@function.outer",
--         ["if"] = "@function.inner",
--         ["ac"] = "@class.outer",
--         ["ic"] = "@class.inner",
--         ["ai"] = "@block.outer",
--         ["im"] = "@block.inner",
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         ["]m"] = "@function.outer",
--         ["]]"] = "@class.outer",
--       },
--       goto_next_end = {
--         ["]M"] = "@function.outer",
--         ["]["] = "@class.outer",
--       },
--       goto_previous_start = {
--         ["[m"] = "@function.outer",
--         ["[["] = "@class.outer",
--       },
--       goto_previous_end = {
--         ["[M"] = "@function.outer",
--         ["[]"] = "@class.outer",
--       },
--     },
--     -- swap = {
--     -- 	enable = true,
--     -- 	swap_next = {
--     -- 		["<leader>a"] = "@parameter.inner",
--     -- 	},
--     -- 	swap_previous = {
--     -- 		["<leader>A"] = "@parameter.inner",
--     -- 	},
--     -- },
--     -- lsp_interop = {
--     --    enable = true,
--     --    border = 'none',
--     --    floating_preview_opts = {},
--     --    peek_definition_code = {
--     --      ["<leader>df"] = "@function.outer",
--     --      ["<leader>dF"] = "@class.outer",
--     --    },
--     --  },
--     -- config for nvim-ts-context-commentstring
--     context_commentstring = {
--       enable = true,
--       enable_autocmd = false,
--     },
--   },
-- })
--
-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
--
-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don"t have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition")

  nmap("gr", function()
    require("telescope.builtin").lsp_references()
  end, "Goto References")

  nmap("gR", function()
    require("telescope.builtin").lsp_references({ jump_type = "vsplit" })

    nmap("<leader>cx", function() vim.diagnostic.open_float({ border = "rounded" }) end,
      { desc = "View Diagnostics In Float Window" })
    -- require("telescope.builtin").lsp_definitions({jump_type="vsplit"})
  end, "Goto References(vsplit)")

  nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
  nmap("gt", vim.lsp.buf.type_definition, "Type Definition")
  nmap("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
  nmap("<leader>cS", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols({
      symbols = {
        "Class",
        "Function",
        "Method",
        "Constructor",
        "Interface",
        "Module",
        "Struct",
        "Trait",
        "Field",
        "Property",
      },
    })
  end, "Workspace Symbols")
  nmap("<leader>sx", require("telescope.builtin").diagnostics, "Diagnostics(Telescope)")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>ck", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  -- nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("<leader>cwa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>cwr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>cwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  nmap("<leader>cI", require("telescope.builtin").lsp_incoming_calls, "lsp_incoming_calls")
  nmap("<leader>cO", require("telescope.builtin").lsp_outgoing_calls, "lsp_outgoing_calls")
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
  nmap("<leader>cf", "<cmd>Format<cr>")
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--  LSP server list:
--  https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  tailwindcss = {},
  html = {},
  angularls = {},
  cssls = {},
  -- denols={},
  -- eslint={},
  -- emmet_ls={},
  -- gradle_ls={},
  -- graphql={},
  -- groovy={},
  jsonls = {},
  jdtls = {},
  -- java_debug_adapter={},
  -- java_test={},
  -- marksman={},
  -- powershell_es={},
  sqlls = {},
  -- svelte={},
  -- taplo={}, toml
  -- lemminx={}, xml
  yamlls = {},
  -- svelte={},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require("neodev").setup({
  -- library = { plugins = { "neotest" }, types = true },
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = 'nvim_lsp_signature_help' },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    format = function(entry, vim_item)
      -- -- Kind icons
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      -- return vim_item

      -- max pop window width limitation
      local ELLIPSIS_CHAR = "…"
      local MAX_LABEL_WIDTH = 50

      local get_ws = function(max, len)
        return (" "):rep(max - len)
      end

      local content = vim_item.abbr
      if #content > MAX_LABEL_WIDTH then
        vim_item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
      else
        vim_item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
      end
      return vim_item
    end,
  },
  sorting = {
    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  window = {
    completion = {
      border = "single",
      max_menu_width = 100,
    },
    documentation = {
      border = "single",
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

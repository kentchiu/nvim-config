-- this config is steal from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/java.lua
return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      -- local JDTLS_LOCATION = "/home/kent/.local/share/nvim/mason/bin/jdtls"
      local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/mason/bin/jdtls"
      print("JDTLS_LOCATION: " .. JDTLS_LOCATION)
      local config = {
        cmd = { JDTLS_LOCATION},
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end
  },

  --[[
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local JDTLS_INSTALL_LOCATION = vim.fn.stdpath "data" .. "/mason/packages/jdtls";
      local JAVA_BIN_LOCATION = '/home/kent/.sdkman/candidates/java/current/bin/java';

      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
      local config_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"


      local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

      -- debug and test
      -- Find the extra bundles that should be passed on the jdtls command-line
      -- if nvim-dap is enabled with java debug/test.
      local mason_registry = require("mason-registry")
      local bundles = {} ---@type string[]
      local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
      local java_dbg_path = java_dbg_pkg:get_install_path()
      local jar_patterns = {
        java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
      }

      -- java test
      local java_test_pkg = mason_registry.get_package("java-test")
      local java_test_path = java_test_pkg:get_install_path()
      vim.list_extend(jar_patterns, { java_test_path .. "/extension/server/*.jar", })

      for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
          table.insert(bundles, bundle)
        end
      end


      -- local bundles2 = {
      --   vim.fn.glob("/home/kent/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar",
      --     1),
      -- };
      --
      -- -- __AUTO_GENERATED_PRINT_VAR_START__
      -- print("function bundles2:", vim.inspect(bundles2)) -- __AUTO_GENERATED_PRINT_VAR_END__
      --
      -- -- This is the new part
      -- vim.list_extend(bundles2,
      --   vim.split(vim.fn.glob("/home/kent/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))
      --
      -- -- __AUTO_GENERATED_PRINT_VAR_START__
      -- print("function bundles2:", vim.inspect(bundles2)) -- __AUTO_GENERATED_PRINT_VAR_END__

      -- Helper function for creating keymaps
      function nnoremap(rhs, lhs, bufopts, desc)
        bufopts.desc = desc
        vim.keymap.set("n", rhs, lhs, bufopts)
      end

      -- The on_attach function is used to set key maps after the language server
      -- attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Regular Neovim LSP client keymappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        -- nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
        -- nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
        -- nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
        -- nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
        -- nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
        -- nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
        -- nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
        -- nnoremap('<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, bufopts, "List workspace folders")
        -- nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
        -- nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
        -- nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
        -- vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
        --   { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })
        -- nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
        --
        -- -- Java extensions provided by jdtls
        -- local jdtls = require('jdtls')
        -- nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
        -- nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
        -- nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")

        print(bufnr)

        -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
        -- you make during a debug session immediately.
        -- Remove the option if you do not want that.
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        require("jdtls.dap").setup_dap_main_class_configs()

        vim.keymap.set("n", "<leader>tjc", require("jdtls.dap").test_class, { desc = "Run All Test" })
        vim.keymap.set("n", "<leader>tjl", require("jdtls.dap").test_nearest_method, { desc = "Run Nearest Test" })
        vim.keymap.set("n", "<leader>tjr", require("jdtls.dap").pick_test, { desc = "Run Test" })
        vim.keymap.set("n", "<leader>t", "<cmd>JdtUpdateDebugConfig<cr>", { desc = "Update Debug Config" })

        -- nnoremap("<leader>tjc", jdtls.test_class, bufopts, "Test class (DAP)")
        -- nnoremap("<leader>tjm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
      end
      -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
      local config = {
        on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {

          -- 💀
          JAVA_BIN_LOCATION, -- or '/path/to/java17_or_newer/bin/java'
          -- depends on if `java` is in your $PATH env variable and if it points to the right version.

          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

          -- 💀
          '-jar',
          JDTLS_INSTALL_LOCATION .. '/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
          -- Must point to the                                                     Change this to
          -- eclipse.jdt.ls installation                                           the actual version


          -- 💀
          '-configuration', JDTLS_INSTALL_LOCATION .. '/config_linux',
          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
          -- Must point to the                      Change to one of `linux`, `win` or `mac`
          -- eclipse.jdt.ls installation            Depending on your system.


          -- 💀
          -- See `data directory configuration` section in the README
          -- '-data', '/path/to/unique/per/project/workspace/folder'
          '-data', workspace_dir,
        },

        -- 💀
        -- This is the default if not provided, you can remove it. Or adjust as needed.
        -- One dedicated LSP server & client will be started per unique root_dir
        root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            -- format = {
            --   enabled = true,
            --   settings = {
            --     url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
            --     profile = "GoogleStyle",
            --   },
            -- },
          },
          signatureHelp = { enabled = true },
          -- Specify any completion options
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*", "sun.*",
            },
          },
          contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
          extendedClientCapabilities = extendedClientCapabilities,
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            hashCodeEquals = {
              useJava7Objects = true,
            },
            useBlocks = true,
          },
        },

        flags = {
          allow_incremental_sync = true,
        },
        -- Language server `initializationOptions`
        -- You need to extend the `bundles` with paths to jar files
        -- if you want to use additional eclipse.jdt.ls plugins.
        --
        -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
        --
        init_options = {
          -- bundles = {
          --   vim.fn.glob(
          --     "/home/kent/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar", 1)
          -- },
          bundles = bundles
        },
      }

      -- config['on_attach'] = function(client, bufnr)
      --   -- __AUTO_GENERATED_PRINT_VAR_START__
      --   print("function#function (client,bufnr):", vim.inspect(client)) -- __AUTO_GENERATED_PRINT_VAR_END__
      --
      --   require('jdtls').setup_dap({ hotcodereplace = 'auto' })
      -- end

      -- This starts a new client & server,
      -- or attaches to an existing client & server depending on the `root_dir`.
      require('jdtls').start_or_attach(config)
      print(vim.inspect(config))

      -- config['init_options'] = {
      --   bundles = bundles;
      -- }
    end

  },
  ]]--

  -- Ensure java debugger and test packages are installed.
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "java-test", "java-debug-adapter" })
        end,
      },
    },
  }
}

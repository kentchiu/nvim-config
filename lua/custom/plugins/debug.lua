return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {

      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end,             desc = "Dap UI" },
          { "<leader>dU", function() require("dapui").open({ reset = true }) end, desc = "Reset Dap UI" },
          {
            "<leader>de",
            function() require("dapui").eval() end,
            desc = "Eval(JUMP)",
            mode = {
              "n", "v" }
          },
          {
            "<leader>df",
            function() require("dapui").float_element("hover") end,
            desc = "Float Element(JUMP)",
            mode = {
              "n", "v" }
          },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end

          -- highlighting
          local dap_breakpoint_color = {
            breakpoint = {
              ctermbg = 0,
              fg = '#993939',
              bg = '#31353f',
            },
            logpoing = {
              ctermbg = 0,
              fg = '#61afef',
              bg = '#31353f',
            },
            stopped = {
              ctermbg = 0,
              fg = '#98c379',
              bg = '#31353f'
            },
          }

          vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
          vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
          vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)

          local dap_breakpoint = {
            error = {
              text = "",
              texthl = "DapBreakpoint",
              linehl = "DapBreakpoint",
              numhl = "DapBreakpoint",
            },
            condition = {
              text = 'ﳁ',
              texthl = 'DapBreakpoint',
              linehl = 'DapBreakpoint',
              numhl = 'DapBreakpoint',
            },
            rejected = {
              text = "",
              texthl = "DapBreakpint",
              linehl = "DapBreakpoint",
              numhl = "DapBreakpoint",
            },
            logpoint = {
              text = '',
              texthl = 'DapLogPoint',
              linehl = 'DapLogPoint',
              numhl = 'DapLogPoint',
            },
            stopped = {
              text = '',
              texthl = 'DapStopped',
              linehl = 'DapStopped',
              numhl = 'DapStopped',
            },
          }

          vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
          vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
          vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
          vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
          vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)


          -- vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint' })
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          enabled = true,
          enable_commands = true,
          highlight_changed_variables = true,
          highlight_new_as_changed = false,
          show_stop_reason = true,
          commented = false,
          only_first_definition = true,
          all_references = false,
          filter_references_pattern = '<module',
          virt_text_pos = 'eol',
          all_frames = false,
          virt_lines = false,
          virt_text_win_col = nil
        },
      },

      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>d"] = { name = "+debug" },
            ["<leader>da"] = { name = "+adapters" },
          },
        },
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },

      -- Add your own debuggers here
      'mfussenegger/nvim-dap-python',
    },

    -- stylua: ignore
    keys = {
      --  to be confirm
      {
        "<leader>da",
        function() require("dap").clear_breakpoints() end,
        desc =
        "Clear Breakpoint"
      },
      {
        "<leader>dA",
        function() require("dap").list_breakpoints() end,
        desc =
        "List Breakpoint"
      },
      {
        "<F5>",
        function() require("dap").continue() end,
        desc =
        "Continue"
      },
      {
        "<F7>",
        function() require("dap").step_into() end,
        desc =
        "Step Into"
      },
      {
        "<S-F8>",
        function() require("dap").step_out() end,
        desc =
        "Step Out"
      },
      {
        "<F8>",
        function() require("dap").step_over() end,
        desc =
        "Step Over"
      },
      --
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc =
        "Breakpoint Condition"
      },
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc =
        "Toggle Breakpoint"
      },
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc =
        "Continue (F5)"
      },
      {
        "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc =
        "Run to Cursor"
      },
      {
        "<leader>dg",
        function() require("dap").goto_() end,
        desc =
        "Go to line (no execute)"
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc =
        "Step Into (F7)"
      },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,   desc = "Up" },
      {
        "<leader>dl",
        function() require("dap").run_last() end,
        desc =
        "Run Last"
      },
      {
        "<leader>dL",
        function() require('dap.ext.vscode').load_launchjs() end,
        desc =
        "Load launchjs"
      },
      {
        "<leader>do",
        function() require("dap").step_out() end,
        desc =
        "Step Out (Shift-F8)"
      },
      {
        "<leader>dO",
        function() require("dap").step_over() end,
        desc =
        "Step Over (F8)"
      },
      {
        "<leader>dp",
        function() require("dap").pause() end,
        desc =
        "Pause"
      },
      {
        "<leader>dr",
        function() require("dap").repl.toggle() end,
        desc =
        "Toggle REPL"
      },
      {
        "<leader>ds",
        function() require("dap").session() end,
        desc =
        "Session"
      },
      {
        "<leader>dt",
        function() require("dap").terminate() end,
        desc =
        "Terminate"
      },
      {
        "<leader>dw",
        function() require("dap.ui.widgets").hover() end,
        desc =
        "Widgets"
      },
    },
    -- maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
    -- maps.n["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
    -- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    -- vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
    -- vim.keymap.set('n', '<Leader>df', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames) end)
    -- vim.keymap.set('n', '<Leader>ds', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes) end)
    -- Close debugger and clear breakpoints
    -- vim.keymap.set("n", "<localleader>de", function()
    --   dap.clear_breakpoints()
    --   ui.toggle({})
    --   dap.terminate()
    --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
    --   require("notify")("Debugger session ended", "warn")
    -- end)
    -- b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },

    config = function()
      -- Install golang specific config
      require('dap-python').setup('./.venv/bin/python')
      require('dap-python').test_runner = 'pytest'
    end,
  }
}

return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {

      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end,  desc = "Dap UI" },
          { "<leader>dU", function() require("dapui").open({reset = true}) end,  desc = "Reset Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,      desc = "Eval(JUMP)",  mode = { "n", "v" } },
          { "<leader>df", function() require("dapui").float_element("hover") end,      desc = "Float Element(JUMP)",  mode = { "n", "v" } },
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
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
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
      { "<leader>da", function() require("dap").clear_breakpoints() end,                                    desc = "Clear Breakpoint" }, 
      { "<leader>dA", function() require("dap").list_breakpoints() end,                                    desc = "List Breakpoint" }, 


      { "<F5>", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<F7>", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<S-F8>", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<F8>", function() require("dap").step_over() end,                                            desc = "Step Over" },
      --
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" }, 
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue (F5)" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into (F7)" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>dL", function() require('dap.ext.vscode').load_launchjs() end,                             desc = "Load launchjs" } ,
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out (Shift-F8)" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over (F8)" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
    -- maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
    -- maps.n["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
      
     




    config = function()
      -- local Config = require("lazyvim.config")
      -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      --
      -- for name, sign in pairs(Config.icons.dap) do
      --   sign = type(sign) == "table" and sign or { sign }
      --   vim.fn.sign_define(
      --     "Dap" .. name,
      --     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      --   )
      -- end

      -- Install golang specific config
      require('dap-python').setup('./.venv/bin/python')
      require('dap-python').test_runner = 'pytest'
    end,
  }
}

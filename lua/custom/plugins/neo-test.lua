return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python",
  },
  keys = {
    { "<leader>;",  function() require("neotest").run.run() end,                     desc = "Test Current Method" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Toggle Test Summary" },
    { "<leader>tm", function() require("neotest").run.run() end,                     desc = "Test Current Method" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Test Current File" },
    { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end,      desc = "Test All" },
    { "<leader>tl", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug The Nearest Test" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Output Of Test Results" },
    { "<leader>tp", function() require("neotest").output_panel.toggle() end,         desc = "Output Terminal" },
  },
  config = function()
    require("neotest").setup({
      quickfix = {
        enabled = false,
        open = false
      },
      adapters = {

        require("neotest-python")({
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { 
            justMyCode = false,
            console = "integratedTerminal",
          },
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          args = { "--log-level", "DEBUG", "--quiet" },
          -- args = { "-vv", "-s" },
          -- Runner to use. Will use pytest if available by default.
          -- Can be a function to return dynamic value.
          runner = "pytest",
          -- Custom python path for the runner.
          -- Can be a string or a list of strings.
          -- Can also be a function to return dynamic value.
          -- If not provided, the path will be inferred by checking for
          -- virtual envs in the local directory and for Pipenev/Poetry configs
          -- python = ".venv/bin/python",
          -- Returns if a given file path is a test file.
          -- NB: This function is called a lot so don't perform any heavy tasks within it.
          -- is_test_file = function(file_path)
          -- end,
        })
      }
    })
  end,
}

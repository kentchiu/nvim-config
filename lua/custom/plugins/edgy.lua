return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = "toggleterm",
        size = { height = 0.4 },
        -- exclude floating windows
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      "Trouble",
      { ft = "qf",            title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
    },
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = "NvimTree",
        ft = "NvimTree",
      },
      {
        ft = "Outline",
        pinned = true,
        open = "SymbolsOutline",
        size = { height = 0.5 },
      },
      {
        title = "Test Summary",
        ft = "neotest-summary",
      }
    },
  },
}

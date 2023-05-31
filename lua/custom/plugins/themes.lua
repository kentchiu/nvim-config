return {
  -- {
  --   "navarasu/onedark.nvim",
  --   -- priority = 1000,
  --   -- config = function()
  --   --   vim.cmd.colorscheme "onedark"
  --   -- end,
  -- },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme "kanagawa"
    -- end,
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme "onedark"
    -- end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme "tokyonight"
    -- end,
  },
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme "dracula"
    -- end,
  },
  {
    'projekt0n/github-nvim-theme',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
      })

      -- random theme
      local items = { "onedarkpro", "kanagawa", "tokyonight", "dracula",
        "github_light", "github_light_default",
        "github_dark", "github_dark_dimmed", "github_dark_high_contrast" }

      math.randomseed(os.time())
      local random_index = math.random(1, #items)
      local random_schema = "colorscheme" .. " " .. items[random_index]
      print("Theme: " .. random_schema)
      vim.cmd(random_schema)
    end,
  }
}

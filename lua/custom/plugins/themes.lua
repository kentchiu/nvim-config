return {
  { "rebelot/kanagawa.nvim", },
  { "olimorris/onedarkpro.nvim", },
  { "folke/tokyonight.nvim", },
  { "Mofiqul/dracula.nvim", },
  { "catppuccin/nvim" },
  {
    'projekt0n/github-nvim-theme',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
      })
      -- random theme
      local items = {
        "onedark", "onedark_vivid", "onedark_dark",
        "tokyonight", "tokyonight-night", "tokyonight-storm", "tokyonight-moon",
        "dracula", "dracula-soft",
        -- "kanagawa", "kanagawa-wave", "kanagawa-dragon",
        "github_dark", "github_dark_dimmed",
        -- "catppuccin", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha",
      }

      math.randomseed(os.time())
      local random_index = math.random(1, #items)
      local random_schema = "colorscheme" .. " " .. items[random_index]
      print("Theme: " .. random_schema)
      vim.cmd(random_schema)
    end,
  }
}

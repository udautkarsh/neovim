
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown"},
    config = function()
      require("render-markdown").setup({
        render_modes = { "n" }, -- render only in normal mode
        anti_conceal = {
          enabled = false, -- completely disable the cursor reveal
        },
        heading = {
          enabled = true,
          sign = true,
          icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
        },
        bullet = {
          enabled = true,
          icons = { "•", "◦", "‣" },
        },
        checkbox = {
          enabled = true,
          icons = { "", "" },
        },
        quote = {
          enabled = true,
          icon = "┃",
        },
        code = {
          enabled = true,
          sign = true,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    }
  }
}







--[[
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        render_modes = { "n" }, -- Render only in normal mode
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    }
  }
}
--]]
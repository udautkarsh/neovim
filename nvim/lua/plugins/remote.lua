return {
    {
      "amitds1997/remote-nvim.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("remote-nvim").setup()
      end,
    },
    {
      "ojroques/nvim-osc52",
      config = function()
        require("osc52").setup()
      end,
    },
  }
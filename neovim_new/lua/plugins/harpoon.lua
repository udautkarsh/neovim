-- ============================================
-- Harpoon - Quick file bookmarks
-- ============================================
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
  end,
  keys = {
    { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon Add" },
    { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Menu" },
    { "<C-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
    { "<C-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
    { "<C-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
    { "<C-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
  },
}

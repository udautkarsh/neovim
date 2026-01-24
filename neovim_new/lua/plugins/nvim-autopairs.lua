-- ============================================
-- nvim-autopairs - Auto-close brackets/quotes
-- ============================================

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- For integration with cmp
  },
  config = function()
    local autopairs = require("nvim-autopairs")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    
    autopairs.setup({
      check_ts = true, -- Enable treesitter
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- Don't add pairs in javascript template_string
        python = { "string" }, -- Don't add pairs in python strings
      },
    })
    
    -- Integrate with nvim-cmp
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}

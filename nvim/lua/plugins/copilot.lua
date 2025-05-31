return {
  -- GitHub Copilot Core Integration
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true, -- Automatically trigger suggestions on insert
      },
      panel = { enabled = true },
      filetypes = {
        ["*"] = true, -- Enable Copilot suggestions for all filetypes
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- Bridge Copilot with nvim-cmp completions
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- Attach copilot_cmp when an LSP client from Copilot attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "copilot" then
            copilot_cmp._on_insert_enter({})
          end
        end,
      })
    end,
  },
}

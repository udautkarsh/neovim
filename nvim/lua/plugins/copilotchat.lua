return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        cmd = "CopilotChat",
        opts = function()
          local user = vim.env.USER or "User"
          user = user:sub(1, 1):upper() .. user:sub(2)
          return {
            auto_insert_mode = true,
            question_header = "  " .. user .. " ",
            answer_header = "  Copilot ",
            window = {
              width = 0.4,
            },
          }
        end,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-telescope/telescope.nvim",
          "zbirenbaum/copilot.lua", -- Ensure copilot.lua is loaded before CopilotChat
        },
        config = function(_, opts)
          local chat = require("CopilotChat")
      
          vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "copilot-chat",
            callback = function()
              vim.opt_local.relativenumber = false
              vim.opt_local.number = false
            end,
          })
      
          chat.setup(opts)
        end,
   }, 
}

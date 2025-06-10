return {
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "theHamsta/nvim-dap-virtual-text",
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_python = require("dap-python")
  
        require("dapui").setup({})
        require("nvim-dap-virtual-text").setup({
          commented = true, -- Show virtual text alongside comment
          enabled = true, -- Enable virtual text
          show_stop_reason = true, -- Show the reason for stopping
          virt_text_pos = "eol" -- Position of virtual text
        })
  
        dap_python.setup("python3")
  
        vim.fn.sign_define("DapBreakpoint", {
          text = "",
          texthl = "DiagnosticSignError",
          linehl = "",
          numhl = "",
        })
  
        vim.fn.sign_define("DapBreakpointRejected", {
          text = "", -- or "❌"
          texthl = "DiagnosticSignError",
          linehl = "",
          numhl = "",
        })
  
        vim.fn.sign_define("DapStopped", {
          text = "", -- or "→"
          texthl = "DiagnosticSignWarn",
          linehl = "Visual",
          numhl = "DiagnosticSignWarn",
        })
  
        -- Automatically open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
      end,
    },
  }
  

-- ============================================
-- LSP Keymaps
-- ============================================

local M = {}

-- Safe go to definition (handles window closing)
local function safe_definition()
  local win = vim.api.nvim_get_current_win()
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  vim.lsp.buf.definition()
end

M.on_attach = function(client, bufnr)
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Alt + Keys for all code navigation (hold Alt for quick navigation)
  map("<A-CR>", safe_definition, "Goto Definition")             -- Alt + Enter
  map("<A-Left>", "<C-o>", "Go Back")                           -- Alt + Left Arrow
  map("<A-Right>", "<C-i>", "Go Forward")                       -- Alt + Right Arrow
  
  -- LSP Navigation (leader + l prefix for LSP)
  map("<leader>ld", safe_definition, "Goto Definition")
  map("<leader>lD", vim.lsp.buf.declaration, "Goto Declaration")
  map("<leader>lr", vim.lsp.buf.references, "Find References")
  map("<leader>li", vim.lsp.buf.implementation, "Goto Implementation")
  map("<leader>lt", vim.lsp.buf.type_definition, "Goto Type Definition")

  -- Information
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  map("<leader>lk", vim.lsp.buf.signature_help, "Signature Help")
  map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")

  -- Actions
  map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
  map("<leader>cr", vim.lsp.buf.rename, "Rename")
  map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")

  -- Workspace
  map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")

  -- Inlay hints (if supported)
  if client.supports_method("textDocument/inlayHint") then
    map("<leader>ci", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, "Toggle Inlay Hints")
  end
end

return M

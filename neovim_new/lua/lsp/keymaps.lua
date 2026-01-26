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

-- Ensure jump list is updated before navigating
local function set_jump()
  vim.cmd("normal! m'")
end

M.on_attach = function(client, bufnr)
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Alt + Keys for all code navigation (hold Alt for quick navigation)
  map("<A-CR>", function()
    set_jump()
    -- Use LSPSaga if available, fallback to native LSP
    local ok = pcall(vim.cmd, "Lspsaga goto_definition")
    if not ok then
      safe_definition()
    end
  end, "Goto Definition")             -- Alt + Enter
  map("<A-Left>", "<C-o>", "Go Back")                           -- Alt + Left Arrow
  map("<A-Right>", "<C-i>", "Go Forward")                       -- Alt + Right Arrow
  map("<A-Up>", function()
    local ok = pcall(vim.cmd, "Lspsaga peek_definition")
    if not ok then
      safe_definition()
    end
  end, "Peek Definition")            -- Alt + Up Arrow
  map("<A-Down>", function()
    pcall(vim.cmd, "Lspsaga finder")
  end, "LSP Finder")                 -- Alt + Down Arrow
  
  -- Space + Arrows for LSPSaga navigation
  map("<leader><CR>", function()
    local ok = pcall(vim.cmd, "Lspsaga peek_definition")
    if not ok then
      safe_definition()
    end
  end, "Peek Definition")
  map("<leader><Up>", function()
    local ok = pcall(vim.cmd, "Lspsaga peek_definition")
    if not ok then
      safe_definition()
    end
  end, "Peek Definition")
  map("<leader><Down>", function()
    pcall(vim.cmd, "Lspsaga finder")
  end, "LSP Finder")
  map("<leader><Left>", "<C-o>", "Go Back")
  map("<leader><Right>", "<C-i>", "Go Forward")
  
  -- LSP Navigation with LSPSaga (leader + d prefix for definition/navigation)
  map("<leader>dd", function()
    local ok = pcall(vim.cmd, "Lspsaga peek_definition")
    if not ok then
      safe_definition()
    end
  end, "Peek Definition")
  map("<leader>dD", function()
    local ok = pcall(vim.cmd, "Lspsaga goto_definition")
    if not ok then
      safe_definition()
    end
  end, "Go to Definition")
  map("<leader>df", function()
    pcall(vim.cmd, "Lspsaga finder")
  end, "LSP Finder")
  map("<leader>dr", vim.lsp.buf.references, "Find References")
  map("<leader>dR", vim.lsp.buf.declaration, "Goto Declaration")
  map("<leader>di", vim.lsp.buf.implementation, "Goto Implementation")
  map("<leader>dt", vim.lsp.buf.type_definition, "Goto Type Definition")

  -- Information (LSPSaga enhanced)
  map("K", function()
    local ok = pcall(vim.cmd, "Lspsaga hover_doc")
    if not ok then
      vim.lsp.buf.hover()
    end
  end, "Hover Documentation")
  map("<leader>dk", vim.lsp.buf.signature_help, "Signature Help")
  map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")

  -- Actions (LSPSaga enhanced)
  map("<leader>ca", function()
    local ok = pcall(vim.cmd, "Lspsaga code_action")
    if not ok then
      vim.lsp.buf.code_action()
    end
  end, "Code Action", { "n", "v" })
  map("<leader>cr", function()
    local ok = pcall(vim.cmd, "Lspsaga rename")
    if not ok then
      vim.lsp.buf.rename()
    end
  end, "Rename")
  map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")

  -- Workspace
  map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")

  -- Diagnostics (LSPSaga)
  map("[d", function()
    local ok = pcall(vim.cmd, "Lspsaga diagnostic_jump_prev")
    if not ok then
      vim.diagnostic.goto_prev()
    end
  end, "Prev Diagnostic")
  map("]d", function()
    local ok = pcall(vim.cmd, "Lspsaga diagnostic_jump_next")
    if not ok then
      vim.diagnostic.goto_next()
    end
  end, "Next Diagnostic")

  -- Inlay hints (if supported)
  if client.supports_method("textDocument/inlayHint") then
    map("<leader>ci", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, "Toggle Inlay Hints")
  end
end

return M

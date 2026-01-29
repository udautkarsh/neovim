local map = vim.keymap.set

-- ============================================
-- COMMENTING (Alt+c)
-- ============================================
-- Remap built-in comment operator from 'gc' to Alt+c
map("n", "<A-c>", "gc", { remap = true, desc = "Comment operator" })
map("n", "<A-c><A-c>", "gcc", { remap = true, desc = "Comment line" })
map("v", "<A-c>", "gc", { remap = true, desc = "Comment selection" })

-- ============================================
-- GENERAL
-- ============================================
-- Alt+Enter for go to definition (global fallback)
map("n", "<A-CR>", function()
  vim.cmd("normal! m'")
  if vim.lsp.buf_get_clients() and #vim.lsp.buf_get_clients() > 0 then
    vim.lsp.buf.definition()
  else
    vim.notify("LSP not attached", vim.log.levels.WARN)
  end
end, { desc = "Go to Definition" })

-- Alt+Arrow navigation (global)
local function jump_back()
  vim.cmd("normal! <C-o>")
end

local function jump_forward()
  vim.cmd("normal! <C-i>")
end

map("n", "<A-Left>", jump_back, { desc = "Go Back" })
map("n", "<A-Right>", jump_forward, { desc = "Go Forward" })
map("n", "<A-S-Up>", function()
  if vim.lsp.buf_get_clients() and #vim.lsp.buf_get_clients() > 0 then
    local ok = pcall(vim.cmd, "Lspsaga peek_definition")
    if not ok then
      vim.lsp.buf.definition()
    end
  else
    vim.notify("LSP not attached", vim.log.levels.WARN)
  end
end, { desc = "Peek Definition" })
map("n", "<A-S-Down>", function()
  if vim.lsp.buf_get_clients() and #vim.lsp.buf_get_clients() > 0 then
    vim.lsp.buf.references()
  else
    vim.notify("LSP not attached", vim.log.levels.WARN)
  end
end, { desc = "Find References" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all" })

-- Better escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- ============================================
-- NAVIGATION
-- ============================================
-- Better up/down (handles wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Shift+Arrow keys for visual selection (like regular editors)
map("n", "<S-Up>", "v<Up>", { desc = "Select up" })
map("n", "<S-Down>", "v<Down>", { desc = "Select down" })
map("n", "<S-Left>", "v<Left>", { desc = "Select left" })
map("n", "<S-Right>", "v<Right>", { desc = "Select right" })
map("v", "<S-Up>", "<Up>", { desc = "Extend selection up" })
map("v", "<S-Down>", "<Down>", { desc = "Extend selection down" })
map("v", "<S-Left>", "<Left>", { desc = "Extend selection left" })
map("v", "<S-Right>", "<Right>", { desc = "Extend selection right" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Prev search centered" })

-- ============================================
-- WINDOWS
-- ============================================
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Window navigation (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window navigation (Ctrl + Arrow keys)
map("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to right window" })

-- Jump to Explorer with Ctrl+Up (simplified - just go left to explorer)
map("n", "<C-Up>", "<C-w>h", { desc = "Jump to Explorer (go left)" })

-- Resize windows (Ctrl + Shift + Arrow keys)
map("n", "<C-S-Up>", "<cmd>resize -2<CR>", { desc = "Resize up" })
map("n", "<C-S-Down>", "<cmd>resize +2<CR>", { desc = "Resize down" })
map("n", "<C-S-Left>", "<cmd>vertical resize +2<CR>", { desc = "Resize left" })
map("n", "<C-S-Right>", "<cmd>vertical resize -2<CR>", { desc = "Resize right" })

-- ============================================
-- BUFFERS
-- ============================================
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to other buffer" })

-- ============================================
-- TABS
-- ============================================
map("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader><tab>x", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- ============================================
-- INDENTING
-- ============================================
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- ============================================
-- PASTE / YANK
-- ============================================
map("v", "p", '"_dP', { desc = "Paste without yank" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- ============================================
-- QUICKFIX / LOCATION LIST
-- ============================================
map("n", "<leader>xl", "<cmd>lopen<CR>", { desc = "Location list" })
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Quickfix list" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Prev quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[l", "<cmd>lprev<CR>", { desc = "Prev location" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })

-- ============================================
-- DIAGNOSTICS
-- ============================================
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ============================================
-- ADD BLANK LINES
-- ============================================
map("n", "]<space>", "o<Esc>k", { desc = "Add blank line below" })
map("n", "[<space>", "O<Esc>j", { desc = "Add blank line above" })

-- ============================================
-- TERMINAL
-- ============================================
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })

-- ============================================
-- BLOCK / INDENT NAVIGATION
-- ============================================
map("n", "[i", function()
  -- Jump to start of current indent block
  local current_indent = vim.fn.indent(".")
  local line = vim.fn.line(".") - 1
  while line > 0 do
    local indent = vim.fn.indent(line)
    local text = vim.fn.getline(line)
    if indent < current_indent and text:match("%S") then
      vim.cmd(tostring(line))
      return
    end
    line = line - 1
  end
end, { desc = "Jump to start of indent block" })

map("n", "]i", function()
  -- Jump to end of current indent block
  local current_indent = vim.fn.indent(".")
  local line = vim.fn.line(".") + 1
  local last_line = vim.fn.line("$")
  while line <= last_line do
    local indent = vim.fn.indent(line)
    local text = vim.fn.getline(line)
    if indent < current_indent and text:match("%S") then
      vim.cmd(tostring(line))
      return
    end
    line = line + 1
  end
end, { desc = "Jump to end of indent block" })

-- ============================================
-- LINE NUMBERS
-- ============================================
-- Cycle through line number modes: both → absolute only → relative only → both
map("n", "<A-S-l>", function()
  local has_number = vim.wo.number
  local has_relative = vim.wo.relativenumber
  
  if has_number and has_relative then
    -- Both → Absolute only
    vim.wo.relativenumber = false
    vim.wo.number = true
    vim.notify("Line numbers: Absolute only", vim.log.levels.INFO)
  elseif has_number and not has_relative then
    -- Absolute only → Relative only
    vim.wo.number = false
    vim.wo.relativenumber = true
    vim.notify("Line numbers: Relative only", vim.log.levels.INFO)
  elseif not has_number and has_relative then
    -- Relative only → Both
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.notify("Line numbers: Both (absolute + relative)", vim.log.levels.INFO)
  else
    -- None → Both
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.notify("Line numbers: Both (absolute + relative)", vim.log.levels.INFO)
  end
end, { desc = "Cycle Line Number Modes" })

-- ============================================
-- LAZY
-- ============================================
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy" })

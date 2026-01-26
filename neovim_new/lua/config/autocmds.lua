local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ============================================
-- PROJECT ROOT (dynamic detection)
-- ============================================
-- Find project root by looking for common root markers
local function find_project_root(path)
  local root_markers = { ".git", ".gitignore", "Makefile", "package.json", "pyproject.toml", "Cargo.toml", "go.mod" }
  local current = path or vim.fn.expand("%:p:h")
  
  -- Walk up the directory tree
  while current and current ~= "/" do
    for _, marker in ipairs(root_markers) do
      if vim.fn.isdirectory(current .. "/" .. marker) == 1 or vim.fn.filereadable(current .. "/" .. marker) == 1 then
        return current
      end
    end
    current = vim.fn.fnamemodify(current, ":h")
  end
  
  return nil
end

-- Initialize project root from startup args or cwd
vim.g.project_root = (function()
  local args = vim.fn.argv()
  if #args > 0 then
    local arg = args[1]
    local start_path
    if vim.fn.isdirectory(arg) == 1 then
      start_path = vim.fn.fnamemodify(arg, ":p")
    else
      start_path = vim.fn.fnamemodify(arg, ":p:h")
    end
    return find_project_root(start_path) or start_path
  end
  return find_project_root(vim.fn.getcwd()) or vim.fn.getcwd()
end)()

-- Update project root when opening files from a different project
local project_root_group = vim.api.nvim_create_augroup("ProjectRoot", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = project_root_group,
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" or vim.bo.buftype ~= "" then
      return
    end
    
    local file_dir = vim.fn.fnamemodify(bufname, ":p:h")
    local new_root = find_project_root(file_dir)
    
    if new_root and new_root ~= vim.g.project_root then
      vim.g.project_root = new_root
      -- Also update cwd to match
      vim.cmd("cd " .. vim.fn.fnameescape(new_root))
    end
  end,
  desc = "Update project root when switching projects",
})

-- ============================================
-- GENERAL AUTOCOMMANDS
-- ============================================
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Resize splits when window is resized
autocmd("VimResized", {
  group = general,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Resize splits on window resize",
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  group = general,
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last location when opening buffer",
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = general,
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns.blame",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with q",
})

-- Wrap and spell check in text files
autocmd("FileType", {
  group = general,
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Wrap and spell check text files",
})

-- Fix conceallevel for json files
autocmd("FileType", {
  group = general,
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  desc = "Fix conceallevel for JSON",
})

-- Auto create dir when saving file
autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto create dir on save",
})

-- ============================================
-- TERMINAL AUTOCOMMANDS
-- ============================================
local terminal = augroup("Terminal", { clear = true })

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = terminal,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Terminal settings",
})

-- ============================================
-- CURSOR LINE (only in active window)
-- ============================================
local cursorline = augroup("CursorLine", { clear = true })

autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursorline,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
  desc = "Show cursorline",
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorline,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
  desc = "Hide cursorline",
})

-- ============================================
-- TROUBLE WINDOW NAVIGATION (Ctrl+Arrows)
-- ============================================
autocmd("FileType", {
  group = general,
  pattern = "trouble",
  callback = function()
    local opts = { buffer = true, silent = true }
    vim.keymap.set("n", "<C-Up>", "<cmd>wincmd k<CR>", opts)
    vim.keymap.set("n", "<C-Down>", "<cmd>wincmd j<CR>", opts)
    vim.keymap.set("n", "<C-Left>", "<cmd>wincmd h<CR>", opts)
    vim.keymap.set("n", "<C-Right>", "<cmd>wincmd l<CR>", opts)
  end,
  desc = "Ctrl+Arrow navigation in Trouble",
})

-- ============================================
-- CHECKTIME (auto reload files changed outside)
-- ============================================
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = general,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check for file changes",
})

-- ============================================
-- MAX BUFFER LIMIT
-- ============================================
local max_buffers = augroup("MaxBuffers", { clear = true })

-- Maximum number of open buffers (change this value as needed)
vim.g.max_open_buffers = 20  -- Increased from 5 to 20

autocmd("BufEnter", {
  group = max_buffers,
  callback = function()
    local max = vim.g.max_open_buffers or 5
    
    -- Get all listed buffers (real files, not special buffers)
    local buffers = vim.tbl_filter(function(buf)
      return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buflisted
        and vim.bo[buf].buftype == ""
    end, vim.api.nvim_list_bufs())
    
    -- If we exceed the limit, close the oldest buffers
    if #buffers > max then
      -- Sort by last used (oldest first)
      table.sort(buffers, function(a, b)
        return vim.fn.getbufinfo(a)[1].lastused < vim.fn.getbufinfo(b)[1].lastused
      end)
      
      -- Close oldest buffers to get back to the limit
      local to_close = #buffers - max
      for i = 1, to_close do
        local buf = buffers[i]
        -- Don't close modified buffers
        if not vim.bo[buf].modified then
          vim.api.nvim_buf_delete(buf, { force = false })
        end
      end
    end
  end,
  desc = "Limit max open buffers",
})

-- ============================================
-- Utility Functions
-- ============================================
-- Reusable helper functions for your config.
-- ============================================

local M = {}

--- Check if a plugin is installed
---@param plugin string Plugin name
---@return boolean
M.has_plugin = function(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

--- Get the current buffer's root directory
---@return string
M.get_root = function()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    root = vim.fs.find({ ".git", "lua" }, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
  end
  return root
end

--- Check if we're in a git repo
---@return boolean
M.is_git_repo = function()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

--- Get visual selection
---@return string
M.get_visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})
  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

--- Safe require (returns nil if module doesn't exist)
---@param module string Module name
---@return any|nil
M.safe_require = function(module)
  local ok, result = pcall(require, module)
  if ok then
    return result
  end
  return nil
end

--- Create an autocommand group
---@param name string Group name
---@return integer
M.augroup = function(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

--- Check if Neovim is running in a terminal with GUI capabilities
---@return boolean
M.is_gui = function()
  return vim.fn.has("gui_running") == 1 or vim.g.neovide ~= nil
end

--- Toggle an option
---@param option string Option name
---@param silent? boolean Don't show notification
M.toggle_option = function(option, silent)
  local value = not vim.opt_local[option]:get()
  vim.opt_local[option] = value
  if not silent then
    vim.notify(option .. " set to " .. tostring(value))
  end
end

return M

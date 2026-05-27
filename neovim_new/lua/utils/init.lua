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

-- ============================================
-- Python venv resolution (used by pyright)
-- ============================================

local function is_executable(path)
  return path and vim.fn.executable(path) == 1
end

local function path_join(...)
  return table.concat({ ... }, "/")
end

--- Find the python executable inside a venv directory
---@param venv_dir string
---@return string|nil
local function python_in_venv(venv_dir)
  local candidates = {
    path_join(venv_dir, "bin", "python"),
    path_join(venv_dir, "bin", "python3"),
    path_join(venv_dir, "Scripts", "python.exe"),
  }
  for _, p in ipairs(candidates) do
    if vim.uv.fs_stat(p) then
      return p
    end
  end
  return nil
end

--- Walk up from `start` to find any of the `names` as a directory or file
---@param start string
---@param names string[]
---@return string|nil  -- full path to the match
local function find_upward(start, names)
  local found = vim.fs.find(names, {
    path = start,
    upward = true,
    type = "directory",
  })[1]
  if found then return found end
  return vim.fs.find(names, {
    path = start,
    upward = true,
    type = "file",
  })[1]
end

--- Best-effort discovery of a Python interpreter for the given root.
--- Priority:
---   1. cached override (set by venv-selector or :PySetPython)
---   2. $VIRTUAL_ENV (an already-activated venv)
---   3. <root>/.venv, venv, env, .virtualenv  (walked upward)
---   4. poetry env info -p   (if pyproject.toml has [tool.poetry])
---   5. pipenv --venv        (if Pipfile is present)
---   6. system python3
---@param root string|nil  Project root (defaults to cwd)
---@return string  -- absolute path to a python interpreter
M.get_python_path = function(root)
  root = root or vim.uv.cwd() or "."

  -- 1. user override
  if vim.g.python3_host_prog and is_executable(vim.g.python3_host_prog) then
    return vim.g.python3_host_prog
  end

  -- 2. $VIRTUAL_ENV
  local venv_env = os.getenv("VIRTUAL_ENV")
  if venv_env and venv_env ~= "" then
    local p = python_in_venv(venv_env)
    if p then return p end
  end

  -- 3. local venv folders (walked upward from root)
  local venv_names = { ".venv", "venv", "env", ".virtualenv" }
  local venv_dir = find_upward(root, venv_names)
  if venv_dir then
    local p = python_in_venv(venv_dir)
    if p then return p end
  end

  -- 4. poetry
  if find_upward(root, { "pyproject.toml" }) and vim.fn.executable("poetry") == 1 then
    local out = vim.fn.system({ "poetry", "-C", root, "env", "info", "-p" })
    if vim.v.shell_error == 0 then
      local poetry_venv = vim.trim(out)
      local p = python_in_venv(poetry_venv)
      if p then return p end
    end
  end

  -- 5. pipenv
  if find_upward(root, { "Pipfile" }) and vim.fn.executable("pipenv") == 1 then
    local out = vim.fn.system({ "pipenv", "--venv" })
    if vim.v.shell_error == 0 then
      local pipenv_venv = vim.trim(out)
      local p = python_in_venv(pipenv_venv)
      if p then return p end
    end
  end

  -- 6. fallback: system python3
  return vim.fn.exepath("python3") or "python3"
end

return M

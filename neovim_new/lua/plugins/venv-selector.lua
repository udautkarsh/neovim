-- ============================================
-- Venv Selector - Manual override for Python venv
-- ============================================
-- Auto-detection lives in lua/utils/init.lua (get_python_path),
-- and is wired into pyright via `before_init` in lua/lsp/servers.lua.
--
-- This plugin adds an interactive picker for cases where you want to
-- override the auto-detected interpreter (multiple venvs in repo, a venv
-- outside the project tree, conda env, pyenv, etc.). It picks venvs found
-- by `fd` and re-activates pyright/dap-python with the new interpreter.
--
-- Picker is set to "snacks" since this config uses Snacks.picker.
-- ============================================

return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "folke/snacks.nvim",
    -- Optional: keep dap-python aware of the chosen interpreter.
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
  },
  ft = "python",
  cmd = { "VenvSelect", "VenvSelectCached", "VenvSelectLog" },
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<CR>",       desc = "Select Python venv" },
    { "<leader>vc", "<cmd>VenvSelectCached<CR>", desc = "Use cached venv" },
  },
  opts = {
    options = {
      picker = "snacks",
      notify_user_on_venv_activation = true,
      cached_venv_automatic_activation = true,
      -- Show the source (cwd, poetry, pyenv, ...) that found each venv
      show_telescope_search_type = true,
    },
    -- The defaults already cover cwd / poetry / pyenv / pipenv / conda /
    -- hatch / virtualenvwrapper. Add custom locations here if needed.
    search = {},
  },
}

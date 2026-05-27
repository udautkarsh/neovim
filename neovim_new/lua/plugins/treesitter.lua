-- ============================================
-- Treesitter (main branch) - Neovim 0.12+ compatible
-- ============================================
-- The legacy `master` branch was archived in 2026 and crashes on
-- Neovim 0.12+ (e.g. "attempt to call method 'range' (a nil value)"
-- when opening markdown with fenced code blocks).
--
-- The new `main` branch is a full rewrite that only ships parser
-- installation + queries. Highlighting and indentation are enabled
-- explicitly via a FileType autocmd (see `init`).
--
-- Requirements (handled by scripts/install-neovim.sh):
--   * Neovim >= 0.12
--   * `tree-sitter` CLI in $PATH
--   * a C compiler in $PATH
-- ============================================

local parsers = {
  -- core
  "lua", "vim", "vimdoc", "query", "regex", "bash",
  -- web
  "html", "css", "javascript", "typescript", "tsx", "json", "yaml", "toml",
  -- markdown (needed by render-markdown.nvim)
  "markdown", "markdown_inline",
  -- general purpose
  "python", "go", "rust", "c", "cpp",
  -- ops
  "dockerfile", "diff", "gitcommit", "gitignore",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  priority = 1000,
  build = ":TSUpdate",

  init = function()
    -- Enable treesitter highlighting + indentation on every filetype.
    -- pcall guards against filetypes that don't have a parser installed.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user.treesitter.start", { clear = true }),
      callback = function(args)
        local buf = args.buf
        if not vim.api.nvim_buf_is_valid(buf) then return end

        local ok = pcall(vim.treesitter.start, buf)
        if ok then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,

  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Install any missing parsers asynchronously on startup.
    -- (Synchronous bulk install is done from scripts/install-neovim.sh.)
    local installed = ts.get_installed("parsers") or {}
    local lookup = {}
    for _, p in ipairs(installed) do
      lookup[p] = true
    end

    local missing = {}
    for _, p in ipairs(parsers) do
      if not lookup[p] then
        table.insert(missing, p)
      end
    end

    if #missing > 0 then
      ts.install(missing)
    end
  end,
}

-- ============================================
-- Conform.nvim - Code Formatter
-- Standard formatters for Python, Ansible, and more
-- ============================================

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		-- Formatters by filetype
		formatters_by_ft = {
			-- Python: ruff for formatting (with line length) + ruff_imports for isort
			-- python = { "ruff", "ruff_imports" },

			-- Ansible/YAML
			yaml = { "prettier" },
			["yaml.ansible"] = { "prettier" },
			ansible = { "prettier" },

			-- Web
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },

			-- Shell
			sh = { "shfmt" },
			bash = { "shfmt" },

			-- Lua
			lua = { "stylua" },

			-- Markdown
			markdown = { "prettier" },

			-- Go
			go = { "gofmt", "goimports" },

			-- Fallback
			["_"] = { "trim_whitespace" },
		},

		-- Format on save (disabled - use <leader>cf to format manually)
		format_on_save = false,

		-- Formatter options
		formatters = {
			-- uncomment below section to enable ruff formatting
			-- ruff = {
			-- 	-- Configure ruff with line length
			-- 	-- Line length: 88 (Black default) or 100
			-- 	prepend_args = {
			-- 		"format",
			-- 		"--line-length",
			-- 		"120", -- Set line length (change to 100 if preferred)
			-- 	},
			-- },
			-- uncomment below lines to enable isort
			-- ruff_imports = {
			--   -- Custom formatter to sort imports (isort-compatible)
			--   command = "ruff",
			--   args = { "check", "--fix", "--select", "I", "--stdin-filename", "$FILENAME", "-" },
			--   stdin = true,
			-- },
			shfmt = {
				prepend_args = { "-i", "2" }, -- 2 space indent
			},
			prettier = {
				prepend_args = { "--tab-width", "2" },
			},
		},
	},
	init = function()
		-- Use conform for gq
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

-- LSP Support Configuration
return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Management
    -- https://github.com/mason-org/mason.nvim
    { 'mason-org/mason.nvim' },
    -- https://github.com/mason-org/mason-lspconfig.nvim
    { 'mason-org/mason-lspconfig.nvim' },
    -- Auto-Install LSPs, linters, formatters, debuggers
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },
    -- Enhanced Lua configuration for Neovim
    -- https://github.com/folke/neodev.nvim
    { 'folke/neodev.nvim', opts = {} },
    -- Completion engine and LSP completion support
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
  },
  config = function()
    -- Define lspconfig, capabilities, and on_attach callback.
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Create your buffer-local keybindings here.
      -- Example:
      -- local opts = { noremap = true, silent = true, buffer = bufnr }
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    end

    -- Initialize Mason (LSP/DAP/Formatter Installer).
    require('mason').setup({})

    -- Configure mason-lspconfig to install and set up LSP servers.
    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls',
        'cssls',
        'html',
        'lua_ls',
        'jsonls',
        'lemminx',
        'marksman',
        'quick_lint_js',
        'yamlls',
        'pyright',
        'ansiblels',  -- Added Ansible language server.
        'ruff',       -- ADDED: Ruff LSP integration (use "ruff", not "ruff-lsp").
      },
      handlers = {

        -- Special handler for lua_ls with custom settings.
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { 'vim' } },
              },
            },
          })
        end,

        -- Special handler for ansiblels, activated only for files with filetype 'yaml.ansible'.
        -- Inside your config function, update the ansiblels handler:
        ["ansiblels"] = function()
          lspconfig.ansiblels.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            filetypes = { "yaml.ansible" },
            settings = {
              ansible = {
                validation = {
                  lint = {
                    enabled = true,
                    path = "ansible-lint"
                  }
                },
                ansible = {
                  path = "ansible"
                }
              },
              yaml = {
                format = {
                  enable = true,
                  singleQuote = false,
                  bracketSpacing = true
                },
                validate = true,
                hover = true,
                completion = true,
                schemas = {
                  -- Fixed schema URL syntax
                  ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/definitions/playbook"] = {
                    "*play*.{yml,yaml}"
                  }
                }
            }
          }
          })
        end,
        -- ADDED: Special handler for Ruff LSP.
        ["ruff"] = function()
          lspconfig.ruff.setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            init_options = {
              settings = {
                fix = true,  -- Tell Ruff to apply fixes automatically if supported.
              },
            },
          })
        end,
        -- Default handler for all other servers.
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end,
      },
    })

    -- Setup mason-tool-installer to install formatters/linters/debuggers.
    require('mason-tool-installer').setup({
      ensure_installed = {
        'black',
        'debugpy',
        'flake8',
        'isort',
        'mypy',
        'pylint',
        'ansible-lint',  -- Added ansible-lint for linting Ansible playbooks.
        'ruff',          -- ADDED: Ruff formatter/linter.
      },
    })

    -- Since mason-tool-installer might trigger on VimEnter, explicitly run the installer command.
    vim.cmd('MasonToolsInstall')

    -- Override vim.lsp.util.open_floating_preview to always use a rounded border.
    local original_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      return original_open_floating_preview(contents, syntax, opts, ...)
    end

    -- Configure LSP handlers for hover and signature help with rounded borders.
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
  end,
}


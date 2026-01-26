-- ============================================
-- nvim-cmp - Auto-completion Engine
-- ============================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet engine (already installed via neogen, but listed here for cmp integration)
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    
    -- LSP completion
    "hrsh7th/cmp-nvim-lsp",
    
    -- Additional snippets
    "rafamadriz/friendly-snippets",
    
    -- Buffer and path completion
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    
    -- Command line completion
    "hrsh7th/cmp-cmdline",
    
    -- Function signature help
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    -- Load friendly-snippets (LuaSnip may already be set up by neogen)
    require("luasnip.loaders.from_vscode").lazy_load()
    
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll backward
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll forward
        ["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestions
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        -- Tab through suggestions or when a snippet is active, tab to the next argument
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Tab backwards through suggestions or when a snippet is active, tab to the previous argument
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP
        { name = "nvim_lsp_signature_help" }, -- Function signatures
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      window = {
        -- Add borders to completion popups
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
    
    -- Command line completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
  end,
}

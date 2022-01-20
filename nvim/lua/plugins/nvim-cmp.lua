-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp


local cmp = require 'cmp'
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

cmp.setup {
  -- load snippet support
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

-- completion settings
  completion = {
    completeopt = 'menu,menuone,noselect',
    keyword_length = 2,
  },

  -- key mapping
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Tab mapping
    ['<Tab>'] = function(fallback)
      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    end,

    ['<S-Tab>'] = function(fallback)
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end,
  },

    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end

  -- load sources, see: https://github.com/topics/nvim-cmp
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

-- command line completion
cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

-- lsp document symbols
cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})

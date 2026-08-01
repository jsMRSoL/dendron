return {
  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = vim.tbl_deep_extend('force', capabilities,
  --   require('cmp_nvim_lsp').default_capabilities())
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    'hrsh7th/nvim-cmp',
    opts = function (_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {}
  },
  {
    'onsails/lspkind.nvim',
    event = 'VeryLazy',
  },
  {
    'olexsmir/gopher.nvim',
    event = 'VeryLazy',
    dependencies = { -- dependencies
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  -- { 'jsMRSoL/goalltesty' },
  -- { dir = '~/Projects/lua/goalltesty.nvim/' }
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
}

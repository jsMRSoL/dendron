return {
  'folke/which-key.nvim',
  lazy = false,
  opts = {
    plugins = { spelling = true },
  },
  config = function()
    local wk = require('which-key')
      wk.add({
        mode = { 'n', 'v' },
        { '<leader>b',  group = 'buffer' },
        { '<leader>c',  group = 'quickfix' },
        { '<leader>d',  group = 'dap' },
        { '<leader>du', group = 'dapui' },
        { '<leader>f',  group = 'file/find' },
        { '<leader>g',  group = 'git' },
        { '<leader>l',  group = 'lsp' },
        { '<leader>lw', group = 'workspace' },
        { '<leader>lx', group = 'diagnostics' },
        { '<leader>p',  group = 'packages' },
        { '<leader>q',  group = 'quit/session' },
        { '<leader>s',  group = 'search' },
        { '<leader>t',  group = 'tabs/term/TS' },
        { '<leader>u',  group = 'ui' },
        { '<leader>w',  group = 'windows' },
        { '<leader>x',  group = 'text' },
        { '<leader>xg', group = 'greek' },
        { '<leader>xl', group = 'latin' },
        { '<leader>y',  group = 'yank' },
        { '[',          group = 'prev' },
        { ']',          group = 'next' },
        { 'g',          group = 'goto' },
        { 'gS',         group = 'selectTS' },
        { 'gr',         group = 'increment selection' },
        { 'gz',         group = 'surround' },
      })
  end,
}

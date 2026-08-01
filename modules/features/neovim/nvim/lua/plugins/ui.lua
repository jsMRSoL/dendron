return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function ()
      require('dashboard').setup({
        change_to_vcs_root = true,
        config = {
          header = {
            [[                                __                ]],
            [[   ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[  / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[ /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[ \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            [[                                                  ]],
          },
          mru = {
            limit = 10,
          },
          project = {
            enable = true,
          },
          shortcut = {
            {
              action = function () vim.cmd('Telescope find_files') end,
              desc = 'Files',
              group = 'Label',
              icon = ' ',
              icon_hl = '@variable',
              key = 'f',
            },
            {
              action = function ()
                require('telescope.builtin').find_files({
                  prompt_title = '<= neovim config =>',
                  cwd = '~/.config/nvim/',
                })
              end,
              desc = ' Config',
              group = 'Number',
              key = 'v',
            },
            {
              action = 'q!',
              desc = 'Quit',
              group = 'Label',
              icon = ' ',
              key = 'q',
            },
          }
        }
      })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },
  -- fancy notification boxes
  {
    'rcarriga/nvim-notify',
    event = 'VimEnter',
    config = function ()
      require('notify').setup({
        timeout = 3000,
      })
      vim.notify = require('notify')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = true,
  },
  {
    'chrisbra/Colorizer',
    event = 'VimEnter',
    config = function ()
      vim.cmd[[let g:colorizer_disable_bufleave = 1]]
    end
  },
}

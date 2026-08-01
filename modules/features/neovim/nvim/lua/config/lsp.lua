vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

local virtual_lines_enabled = false

function ToggleVirtualLines()
  virtual_lines_enabled = not virtual_lines_enabled
  vim.diagnostic.config({ virtual_lines = virtual_lines_enabled })
end

vim.diagnostic.config({
  virtual_lines = virtual_lines_enabled,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
})

--- hack to allow Telescope to look nice
--- but have rounded borders on hover windows
local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function ()
  return hover({
    border = 'rounded',
    max_width = math.floor(vim.o.columns * 0.7),
    max_height = math.floor(vim.o.lines * 0.7),
  })
end

local servers = {
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    on_attach = function (_, bufnr)
      local keymap = {
        { ';tf', '<cmd>PlenaryBustedFile %<CR>' },
        { ';td', '<cmd>PlenaryBustedDirectory %:p:h<CR>' },
      }

      for _, v in pairs(keymap) do
        vim.keymap.set('n', v[1], v[2], { noremap = true, buffer = bufnr })
      end
    end,
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        hint = { enable = true },
        diagnostics = {
          -- get the language server to recognise
          -- globals used in plenary tests
          globals = {
            'describe',
            'it',
            'before_each',
            'vim',
          },
          disable = {
            'missing-fields',
          },
        },
      },
    },
  },
  gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go' },
    on_attach = function (_, bufnr)
      require('gopher').setup({})

      -- require('gotestit').setup({
      --   commands = {
      --     gotestsum = gotestsum,
      --   }
      -- })

      local wk = require('which-key')
      wk.add({
        { '<leader>lt', group = '+tags' },
        { '<leader>lT', group = '+tests' },
        { '<leader>lm', group = '+mod' },
      })

      local keymap = {
        { '<leader>lg',  ':GoGet ' },
        { '<leader>lI',  ':GoImpl ' },
        { '<leader>ltj', '<cmd>GoTagAdd json<CR>' },
        { '<leader>lty', '<cmd>GoTagAdd yaml<CR>' },
        { '<leader>lTa', '<cmd>GoTestsAll<CR>' },
        { '<leader>lTA', '<cmd>GoTestAdd<CR>' },
        { '<leader>lTe', '<cmd>GoTestsExp<CR>' },
        { '<leader>lD',  '<cmd>GoCmt' },
        { '<leader>li',  '<cmd>GoIfErr<CR>' },
        { '<leader>lmi', ':GoMod init ' },
        { '<leader>lmt', '<cmd>GoMod tidy<CR>' },
        -- { '<leader>lTT', '<cmd>GoRunThisTest<CR>' },
        -- { '<leader>lTG', '<cmd>GoRunAllTests<CR>' },
        { ';tt',         '<cmd>GoRunThisTest<CR>' },
        { ';td',         '<cmd>GoRunAllTests<CR>' },
      }

      for _, v in pairs(keymap) do
        vim.keymap.set('n', v[1], v[2], { noremap = true, buffer = bufnr })
      end
    end,

  },
  -- nix
  nixd = {
    filetypes = { 'nix' },
    cmd = { 'nixd' },
    settings = {
      nixd = {
        nixpkgs = {
          expr = 'import <nixpkgs> { }',
        },
        formatting = {
          command = { 'nixfmt' },
        },
        options = {
          nixos = {
            expr =
            '(builtins.getFlake \"/home/simon/.nixos\").nixosConfigurations.viv.options'
          },
        },
      },
    },
  },
  -- python
  pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { '.git', 'setup.py', 'pyproject.toml' },
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          ignore = { '*' },
        },
        venvPath = { '.venv' },
      },
    },
  },
  ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
  },
  -- ts/js
  ts_ls = {
    filetypes = { 'ts', 'js' },
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  },
}

for server, config in pairs(servers) do
  vim.lsp.enable(server)
  vim.lsp.config[server] = config
end


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function (event)
    local bufnr = event.buf
    local nmap = function (keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>la', vim.lsp.buf.code_action, 'Code action')
    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    nmap('gd', vim.lsp.buf.definition, 'Go to definition')
    -- Find references for the word under your cursor.
    nmap('gr', require('telescope.builtin').lsp_references,
      'Go to references')
    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    nmap('gI', require('telescope.builtin').lsp_implementations,
      'Go to implementation')
    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    nmap('<leader>ld', vim.lsp.buf.type_definition, 'Type definition')
    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols,
      'Document symbols')
    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    nmap('<leader>lws',
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      'Workspace symbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder,
      'Workspace Add Folder')
    nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder,
      'Workspace Remove Folder')
    nmap('<leader>lwl', function ()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders')
    --
    -- -- Set some keybinds conditional on server capabilities
    nmap('<space>lf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>',
      'Format buffer')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

local fmt_group = vim.api.nvim_create_augroup('autoformat_cmds',
  { clear = true })

local function setup_autoformat(event)
  local id = vim.tbl_get(event, 'data', 'client_id')
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil then
    return
  end

  vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = event.buf })

  local buf_format = function (e)
    vim.lsp.buf.format({
      bufnr = e.buf,
      async = false,
      timeout_ms = 10000,
    })
  end

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = event.buf,
    group = fmt_group,
    desc = 'Format current buffer',
    callback = buf_format,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Setup format on save',
  callback = setup_autoformat,
})

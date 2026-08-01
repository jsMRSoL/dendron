local bufnr = vim.api.nvim_get_current_buf()
local keymap = {
  { '<space>lh',  '<cmd>RustLsp hover actions<CR>' },
  { '<space>lH',  '<cmd>RustLsp hover range<CR>' },
  { '<space>le',  '<cmd>RustLsp expandMacro<CR>' },
  { '<space>l?',  '<cmd>RustLsp explainError cycle<CR>' },
  { '<space>lf',  '<cmd>RustFmt<CR>' },
  { '<space>lR',  '<cmd>RustLsp runnables<CR>' },
  { '<space>lD',  '<cmd>RustLsp debuggables<CR>' },
  { '<space>lt',  '<cmd>RustLsp testables<CR>' },
  { '<space>lmd', '<cmd>RustLsp moveItem down<CR>' },
  { '<space>lmu', '<cmd>RustLsp moveItem up<CR>' },
  { '<space>lc',  '<cmd>RustLsp openCargo<CR>' },
  { '<space>lE',  '<cmd>RustLsp openDocs<CR>' },
  { '<space>lp',  '<cmd>RustLsp parentModule<CR>' },
  { '<space>lj',  '<cmd>RustLsp joinLines<CR>' },
}

for _, v in pairs(keymap) do
  vim.keymap.set('n', v[1], v[2],
    { noremap = true, buffer = bufnr })
end

local wk = require('which-key')
wk.add({
  { '<leader>lm', group = '+move' },
})

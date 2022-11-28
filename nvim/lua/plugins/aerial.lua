
require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    -- Jump up the tree with '[[' or ']]'
    vim.keymap.set('n', '[[', '<cmd>AerialPrevUp<CR>', {buffer = bufnr})
    vim.keymap.set('n', ']]', '<cmd>AerialNextUp<CR>', {buffer = bufnr})
  end
})

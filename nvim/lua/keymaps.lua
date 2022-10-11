-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- clear search highlighting
-- map('n', '<leader>c', ':nohl<cr>', default_opts)
map('n', '<cr>', ':nohl<cr><cr>', default_opts)


-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------

map('n', '<leader>r', ':Telescope live_grep<cr>', default_opts)
map('n', '<leader>tt', ':Telescope find_files<cr>', default_opts)
map('n', '<leader>ts', ':Telescope lsp_document_symbols<cr>', default_opts)
map('n', '<leader>ta', ':Telescope diagnostics<cr>', default_opts)
map('n', '<leader>tc', ':Telescope commands<cr>', default_opts)
map('n', '<leader>tb', ':Telescope file_browser<cr>', default_opts)

map('n', ';', ':lua require(\'telescope.builtin\').buffers({ sort_lastused = true, ignore_current_buffer = true })<cr>', default_opts)

-----------------------------------------------------------
-- Neuron
-----------------------------------------------------------

-- Create a new note after asking for its title.
map("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", default_opts)

-- Open notes.
map("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", default_opts)
-- Open notes associated with the selected tags.
map("n", "<leader>zt", "<Cmd>ZkTags<CR>", default_opts)

-- Search for the notes matching a given query.
map("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", default_opts)
-- Search for the notes matching the current visual selection.
map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", default_opts)

-----------------------------------------------------------
-- Misc
-----------------------------------------------------------

map('n', '<leader>e', ':NvimTreeToggle<cr>', default_opts)

map('n', '<leader>f', ':Format<cr>', default_opts)

map('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', default_opts)


map('n', '<leader>dw', ':lua require\'diaglist\'.open_all_diagnostics()<cr>', default_opts)
map('n', '<leader>d0', ':lua require\'diaglist\'.open_buffer_diagnostics()<cr>', default_opts)

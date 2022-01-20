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
map('n', '<leader>c', ':nohl<cr>', default_opts)


-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------

map('n', '<leader>r', ':Telescope live_grep<cr>', default_opts)
map('n', '<leader>tt', ':Telescope find_files<cr>', default_opts)
map('n', '<leader>ts', ':Telescope lsp_document_symbols<cr>', default_opts)
map('n', '<leader>ta', ':Telescope diagnostics<cr>', default_opts)
map('n', '<leader>tc', ':Telescope commands<cr>', default_opts)
map('n', '<leader>tb', ':Telescope file_browser<cr>', default_opts)


map('n', ';', ':Telescope buffers<cr>', default_opts)

-----------------------------------------------------------
-- Neuron
-----------------------------------------------------------

-- -- create a new note
map('n', '<leader>zn', ':lua require\'neuron/cmd\'.new_edit(require\'neuron/config\'.neuron_dir)<cr>', default_opts)
-- find your notes, click enter to create the note if there are not notes that match
map('n', '<leader>zz', ':lua require\'neuron/telescope\'.find_zettels()<cr>', default_opts)
-- insert the id of the note that is found
map('n', '<leader>zZ', ':lua require\'neuron/telescope\'.find_zettels {insert = true}<cr>', default_opts)
-- find the backlinks of the current note all the note that link this note
map('n', '<leader>zb', ':lua require\'neuron/telescope\'.find_backlinks()<cr>', default_opts)
-- same as above but insert the found id
map('n', '<leader>zB', ':lua require\'neuron/telescope\'.find_backlinks {insert = true}<cr>', default_opts)
-- find all tags and insert
map('n', '<leader>zt', ':lua require\'neuron/telescope\'.find_tags()<cr>', default_opts)
-- start the neuron server and render markdown, auto reload on save
map('n', '<leader>zs', ':lua require\'neuron\'.rib {address = "127.0.0.1:8200", verbose = true}<cr>', default_opts)
-- go to next [[my_link]] or [[[my_link]]]
map('n', '<leader>z]', ':lua require\'neuron\'.goto_next_extmark()<cr>', default_opts)
-- go to previous
map('n', '<leader>z[', ':lua require\'neuron\'.goto_prev_extmark()<cr>', default_opts)


-----------------------------------------------------------
-- Misc
-----------------------------------------------------------

map('n', '<leader>e', ':NvimTreeToggle<cr>', default_opts)

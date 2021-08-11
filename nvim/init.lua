-- neovim config
-- github.com/ojroques

-------------------- HELPERS -------------------------------
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  use 'christoomey/vim-tmux-navigator'

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use {'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
  use {'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat', run = ':TSUpdate' }
  use 'lukas-reineke/indent-blankline.nvim'

  use 'nvim-lua/completion-nvim'

  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

  use 'unblevable/quick-scope'
  use 'machakann/vim-sandwich'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'

  use 'stsewd/sphinx.nvim'
  use 'lervag/vimtex'
  use 'oberblastmeister/neuron.nvim'
  use 'psf/black'

  use 'shaunsingh/nord.nvim'
  use 'hoob3rt/lualine.nvim'

end)

-------------------- PLUGIN SETUP --------------------------
g['mapleader'] = ','
-- telescope
map('n', '<leader>t', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>r', '<cmd>lua require(\'telescope.builtin\').file_browser()<cr>')
map('n', '<leader>e', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', ';', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
-- completion
cmd 'autocmd BufEnter * lua require\'completion\'.on_attach()'

-- fugitive and git
local log = [[\%C(yellow)\%h\%Cred\%d \%Creset\%s \%Cgreen(\%ar) \%Cblue\%an\%Creset]]
map('n', '<leader>g<space>', ':Git ')
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gg', '<cmd>Git<CR>')
map('n', '<leader>gl', fmt('<cmd>term git log --graph --all --format="%s"<CR><cmd>start<CR>', log))
-- indent-blankline
g['indent_blankline_char'] = '┊'
g['indent_blankline_buftype_exclude'] = {'terminal'}
g['indent_blankline_filetype_exclude'] = {'fugitive', 'fzf', 'help', 'man'}
-- vim-sandwich
cmd 'runtime macros/sandwich/keymap/surround.vim'
-- vimtex
g['vimtex_quickfix_mode'] = 0
-- completion-nvim
g['completion_enable_snippet'] = 'UltiSnips'

-------------------- OPTIONS -------------------------------
local indent, width = 2, 80
cmd 'colorscheme nord'
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.cursorline = true               -- Highlight cursor line
opt.expandtab = true                -- Use spaces instead of tabs
opt.formatoptions = 'crqnj'         -- Automatic formatting options
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = indent             -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.signcolumn = 'yes'              -- Show sign column
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.textwidth = width               -- Maximum width of text
opt.updatetime = 100                -- Delay before swap file is saved
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap

-------------------- MAPPINGS ------------------------------
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})

-------------------- TEXT OBJECTS --------------------------
for _, ch in ipairs({
  '<space>', '!', '#', '$', '%', '&', '*', '+', ',', '-', '.',
  '/', ':', ';', '=', '?', '@', '<bslash>', '^', '_', '~', '<bar>',
}) do
  map('x', fmt('i%s', ch), fmt(':<C-u>normal! T%svt%s<CR>', ch, ch), {silent = true})
  map('o', fmt('i%s', ch), fmt(':<C-u>normal vi%s<CR>', ch), {silent = true})
  map('x', fmt('a%s', ch), fmt(':<C-u>normal! F%svf%s<CR>', ch, ch), {silent = true})
  map('o', fmt('a%s', ch), fmt(':<C-u>normal va%s<CR>', ch), {silent = true})
end

-------------------- LSP -----------------------------------
local lsp = require('lspconfig')
for ls, cfg in pairs({
  bashls = {},
  ccls = {},
  jsonls = {},
  pylsp = {root_dir = lsp.util.root_pattern('.git', fn.getcwd())},
}) do lsp[ls].setup(cfg) end
map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {enable = true},
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer', ['if'] = '@function.inner',
        ['ac'] = '@class.outer', ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {['<leader>a'] = '@parameter.inner'},
      swap_previous = {['<leader>A'] = '@parameter.inner'},
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']a'] = '@parameter.outer',
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      goto_previous_start = {
        ['[a'] = '@parameter.outer',
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
    },
  },
}

-------------------- TELESCOPE -----------------------------
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = "shorten",
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

-- NEURON
require('neuron').setup{
    virtual_titles = true,
    mappings = true,
    run = nil, -- function to run when in neuron dir
    neuron_dir = "~/Dropbox/misc/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
    leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
}
-- click enter on [[my_link]] or [[[my_link]]] to enter it
-- map('n', '<CR>', '<cmd>lua require\'neuron\'.enter_link()<CR>')
-- create a new note
map('n', 'gzn', '<cmd>lua require\'neuron/cmd\'.new_edit(require\'neuron\'.config.neuron_dir)<CR>')
-- find your notes, click enter to create the note if there are not notes that match
map('n', 'gzz', '<cmd>lua require\'neuron/telescope\'.find_zettels()<CR>')
-- insert the id of the note that is found
map('n', 'gzZ', '<cmd>lua require\'neuron/telescope\'.find_zettels {insert = true}<CR>')
-- find the backlinks of the current note all the note that link this note
map('n', 'gzb', '<cmd>lua require\'neuron/telescope\'.find_backlinks()<CR>')
-- same as above but insert the found id
map('n', 'gzB', '<cmd>lua require\'neuron/telescope\'.find_backlinks {insert = true}<CR>')
-- find all tags and insert
map('n', 'gzt', '<cmd>lua require\'neuron/telescope\'.find_tags()<CR>')
-- start the neuron server and render markdown, auto reload on save
map('n', 'gzs', '<cmd>lua require\'neuron\'.rib {address = "127.0.0.1:8200", verbose = true}<CR>')
-- go to next [[my_link]] or [[[my_link]]]
map('n', 'gz]', '<cmd>lua require\'neuron\'.goto_next_extmark()<CR>')
-- go to previous
map('n', 'gz[', '<cmd>lua require\'neuron\'.goto_prev_extmark()<CR>')

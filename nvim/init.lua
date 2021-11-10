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

  use { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat', run = ':TSUpdate' }
  use 'lukas-reineke/indent-blankline.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  use { 'LionC/nest.nvim' }

  use 'unblevable/quick-scope'
  use 'machakann/vim-sandwich'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'

  use 'stsewd/sphinx.nvim'
  use 'lervag/vimtex'
  use { 'oberblastmeister/neuron.nvim', branch = 'unstable' }

  use 'shaunsingh/nord.nvim'
  use 'hoob3rt/lualine.nvim'
end)

-------------------- PLUGIN SETUP --------------------------
g['mapleader'] = ','

-- indent-blankline
g['indent_blankline_char'] = '┊'
g['indent_blankline_buftype_exclude'] = {'terminal'}
g['indent_blankline_filetype_exclude'] = {'fugitive', 'fzf', 'help', 'man'}
-- vim-sandwich
cmd 'runtime macros/sandwich/keymap/surround.vim'
-- vimtex
g['vimtex_quickfix_mode'] = 0

-------------------- OPTIONS -------------------------------
local indent, width = 2, 80
cmd 'colorscheme nord'
opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for ls, cfg in pairs({
  ccls = {capabilities = capabilities},
  pylsp = {root_dir = lsp.util.root_pattern('.git', fn.getcwd()), capabilities = capabilities },
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
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

    file_ignore_patterns = { "%.pyc" }
  }
}

-- NEURON
require('neuron').setup{
    virtual_titles = true,
    mappings = true,
    run = nil, -- function to run when in neuron dir
    neuron_dir = "~/Dropbox/misc/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
    leader = "<leader>z", -- the leader key to for all mappings, remember with 'go zettel'
}

-- NVIM-CMP
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- fugitive and git
local log = [[\%C(yellow)\%h\%Cred\%d \%Creset\%s \%Cgreen(\%ar) \%Cblue\%an\%Creset]]

local nest = require('nest')
nest.applyKeymaps {
	-- Remove silent from ; : mapping, so that : shows up in command mode
	{ ';', ':' , options = { silent = false } },
	{ ':', ';' },

	{ '<leader>', {
		-- Telescope
		{ 't', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>' },
		{ 'r', '<cmd>lua require(\'telescope.builtin\').file_browser()<cr>' },
		{ 'e', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>' },
		{ ';', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>' },
    -- Packer
    { 'p', {
      { 'p', '<cmd>PackerSync<cr>' },
      { 's', '<cmd>PackerStatus<cr>' },
    }},
		-- Git
		{ 'g', {
			{ '<space>', ':Git ' },
			{ 'c', '<cmd>Git commit<cr>' },
			{ 'd', '<cmd>Gvdiffsplit<CR>' },
			{ 'l', fmt('<cmd>term git log --graph --all --format="%s"<CR><cmd>start<CR>', log) },
			{ 'p', '<cmd>Git push<cr>' },
			{ 'w', '<cmd>Gwrite<cr>' },
		}},
		-- Zettels
		{ 'z', {
			-- -- click enter on [[my_link]] or [[[my_link]]] to enter it
			-- -- map('n', '<CR>', '<cmd>lua require\'neuron\'.enter_link()<CR>')
			-- -- create a new note
			{ 'n', '<cmd>lua require\'neuron/cmd\'.new_edit(require\'neuron/config\'.neuron_dir)<CR>' },
			-- find your notes, click enter to create the note if there are not notes that match
			{ 'z', '<cmd>lua require\'neuron/telescope\'.find_zettels()<CR>' },
			-- insert the id of the note that is found
			{ 'Z', '<cmd>lua require\'neuron/telescope\'.find_zettels {insert = true}<CR>' },
			-- find the backlinks of the current note all the note that link this note
			{ 'b', '<cmd>lua require\'neuron/telescope\'.find_backlinks()<CR>' },
			-- same as above but insert the found id
			{ 'B', '<cmd>lua require\'neuron/telescope\'.find_backlinks {insert = true}<CR>' },
			-- find all tags and insert
			{ 't', '<cmd>lua require\'neuron/telescope\'.find_tags()<CR>' },
			-- start the neuron server and render markdown, auto reload on save
			{ 's', '<cmd>lua require\'neuron\'.rib {address = "127.0.0.1:8200", verbose = true}<CR>' },
			-- go to next [[my_link]] or [[[my_link]]]
			{ ']', '<cmd>lua require\'neuron\'.goto_next_extmark()<CR>' },
			-- go to previous
			{ '[', '<cmd>lua require\'neuron\'.goto_prev_extmark()<CR>' },
		}},
    -- Vimtex
    { 'v', {
      { 'v', '<cmd>VimtexCompile<cr>' },
      { 'e', '<cmd>VimtexErrors<cr>' },
      { 't', '<cmd>VimtexTocToggle<cr>' },
    }},
	}},
}

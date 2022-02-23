-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

-- Add packages
return packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim'
    }
  }

  -- file explorer
  use 'kyazdani42/nvim-tree.lua'

  -- indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- autopair
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup()
  --   end
  -- }

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- tagviewer
  -- use 'liuchengxu/vista.vim'

  -- treesitter interface
  use 'nvim-treesitter/nvim-treesitter'

  -- colorschemes
  use 'shaunsingh/nord.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'SirVer/ultisnips',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'honza/vim-snippets'
    },
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'petertriho/nvim-scrollbar',
    requires = { 'kevinhwang91/nvim-hlslens' },
    config = function()
      require('scrollbar').setup()
    end
  }

  -- focus window control
  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }

  -- aerial navigator
  -- use 'stevearc/aerial.nvim'


  -- which-key
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end
  }

  -- debugging
  use 'mfussenegger/nvim-dap'

  -- tmux navigator
  use 'alexghergh/nvim-tmux-navigation'

  -- neuron note taking
  use { 'oberblastmeister/neuron.nvim', branch = 'unstable' }

  -- black formatting
  use { 'averms/black-nvim', run = ':UpdateRemotePlugins'}

  -- vimtex
  use 'lervag/vimtex'

  -- lightspeed
  use 'ggandor/lightspeed.nvim'

  -- git interface
  use 'lambdalisue/gina.vim'
end)

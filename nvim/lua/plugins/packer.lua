-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme

local cmd = vim.cmd

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Add packages
return require("packer").startup(function()
	use("wbthomason/packer.nvim") -- packer can manage itself

	-- telescope

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
	})

	-- file explorer
	use("kyazdani42/nvim-tree.lua")

	-- indent line
	use("lukas-reineke/indent-blankline.nvim")

	-- autopair
	-- use {
	--   'windwp/nvim-autopairs',
	--   config = function()
	--     require('nvim-autopairs').setup()
	--   end
	-- }

	-- icons
	use("kyazdani42/nvim-web-devicons")

	-- tagviewer
	-- use 'liuchengxu/vista.vim'

	-- treesitter interface
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- colorschemes
	use({ "shaunsingh/nord.nvim" })
	use({ "EdenEast/nightfox.nvim" })
	use({ "morhetz/gruvbox" })
	use({ "NLKNguyen/papercolor-theme" })
	use({ "sainnhe/everforest" })

	-- LSP
	use("neovim/nvim-lspconfig")
	use({ "onsails/diaglist.nvim" })

	-- autocomplete
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"onsails/lspkind.nvim",
			-- 'SirVer/ultisnips',
			-- 'quangnguyen30192/cmp-nvim-ultisnips',
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	})
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- git labels
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"petertriho/nvim-scrollbar",
		requires = { "kevinhwang91/nvim-hlslens" },
		config = function()
			require("scrollbar").setup()
			require("scrollbar.handlers.search").setup()
		end,
	})

	-- aerial navigator
	use("stevearc/aerial.nvim")

	-- which-key
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	})

	-- debugging
	use({ "mfussenegger/nvim-dap" })
	use({ "mfussenegger/nvim-dap-python" })

	-- tmux navigator
	use({ "alexghergh/nvim-tmux-navigation" })

	-- zettle note taking with zf
	use({ "mickael-menu/zk-nvim" })

	-- code formatting
	use({ "mhartington/formatter.nvim" })

	-- vimtex
	use("lervag/vimtex")

	-- lightspeed
	use("ggandor/lightspeed.nvim")

	-- git interface
	use("tpope/vim-fugitive")

  -- autosaved Sessions
	use("tpope/vim-obsession")

	-- Glow for markdown preview
	use("ellisonleao/glow.nvim")

	-- Highlighting for kitty config
	use({ "fladson/vim-kitty" })

	-- Use JQ to see JSON path
	use("phelipetls/jsonpath.nvim")

  -- Support for terraform
  use('hashivim/vim-terraform')

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

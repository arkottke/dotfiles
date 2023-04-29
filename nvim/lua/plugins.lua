return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "契" },
				topdelete = { text = "契" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	{ "ggandor/flit.nvim" },
	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
		end,
	},
	{
		"shaunsingh/nord.nvim",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false, -- last release is way too old
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-path",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		{ "hrsh7th/cmp-nvim-lua" }, -- Optional
	-- 	},
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		cmp.setup({
	-- 			completion = {
	-- 				completeopt = "menu,menuone,noinsert",
	-- 			},
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					require("luasnip").lsp_expand(args.body)
	-- 				end,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 				["<C-e>"] = cmp.mapping.abort(),
	-- 				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	-- 			}),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "buffer" },
	-- 				{ name = "path" },
	-- 			}),
	-- 		})

	-- 		cmp.setup.filetype("tex", {
	-- 			sources = {
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{
	-- 					name = "buffer",
	-- 					option = {
	-- 						keyword_pattern = [[\k\+]],
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
		config = function()
			local lsp = require("lsp-zero").preset({
				name = "minimal",
				set_lsp_keymaps = true,
				manage_nvim_cmp = true,
				suggest_lsp_servers = false,
			})

      -- Have pyright use environmental variable
      lsp.configure('pyright', {
        single_file_support = false,
        on_attach = function(client, bufnr)

          local util = require("lspconfig/util")
          local path = util.path

          -- From: https://github.com/IceS2/dotfiles/blob/master/nvim/lua/plugins_cfg/mason_ls_and_dap.lua
          local function get_python_path(workspace)
            -- Use activated virtualenv.
            if vim.env.VIRTUAL_ENV then
              return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
            end

            -- Find and use virtualenv in workspace directory.
            for _, pattern in ipairs({ "*", ".*" }) do
              local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
              if match ~= "" then
                return path.join(vim.env.PYENV_ROOT, "versions", path.dirname(match), "bin", "python")
              end
            end

            -- Fallback to system Python.
            return exepath("python3") or exepath("python") or "python"
          end

          local function get_venv(workspace)
            for _, pattern in ipairs({ "*", ".*" }) do
              local match = vim.fn.glob(path.join(workspace, pattern, ".python-local"))
              if match ~= "" then
                return match
              end
            end
          end

          client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
          client.config.settings.venvPath = path.join(vim.env.PYENV_ROOT, "versions")
          client.config.settings.venv = get_venv(client.config.root_dir)
        end
      })

			-- (Optional) Configure lua language server for neovim
			lsp.nvim_workspace()
			lsp.setup()

      -- Add custom snippets
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(plugin)
			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
				},
				extensions = { "neo-tree" },
			}
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		keys = function(plugin, keys)
			-- Populate the keys based on the user's options
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			-- use ms mappings instead of s to prevent conflict with leap
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "BufReadPre",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"folke/lazy.nvim",
		version = false,
		opts = {
			checker = {
				enabled = true,
			},
		},
	},
	{
		"mickael-menu/zk-nvim",
		name = "zk",
		event = "BufReadPost",
		opts = {
			picker = "telescope",
			lsp = {
				-- `config` is passed to `vim.lsp.start_client(config)`
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
					-- on_attach = ...
					-- etc, see `:h vim.lsp.start_client()`
				},

				-- automatically attach buffers in a zk notebook that match the given filetypes
				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
			},
		},
		keys = {
			{ "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", desc = "New note" },
			{ "<leader>zd", "<cmd>ZkNew { dir = 'weekly', date = 'today' }<cr>", desc = "New diary" },
			{ "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' } }<cr>", desc = "Open note" },
			{ "<leader>zt", "<cmd>ZkTags<cr>", desc = "Open note by tag" },
			{
				"<leader>zf",
				"<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<cr>",
				desc = "Open note by query",
			},
			{ "<leader>zf", ":'<,'>ZkMatch<cr>", mode = "v", desc = "Find tag" },
		},
	},
	{
		"phaazon/mind.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function(_, opts)
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup(opts)
		end,
	},
	{ "tpope/vim-fugitive" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    },
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		opts = {
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},
	{
		"alexghergh/nvim-tmux-navigation",
		opts = {
			keybindings = {
				left = "<C-h>",
				down = "<C-j>",
				up = "<C-k>",
				right = "<C-l>",
				last_active = "<C-\\>",
				next = "<C-Space>",
			},
		},
	},
	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
		opts = {
			languages = {
				python = {
					template = {
						annotation_convention = "numpydoc",
					},
				},
			},
		},
	},
	{ "lervag/vimtex", lazy = true, ft = "tex" },
	{
		"Tummetott/reticle.nvim",
		lazy = "BufReadPost",
		config = true,
	},

	{
		"nvim-tree/nvim-tree.lua",
		name = "nvim-tree",
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		keys = {
			{
				"<leader>nt",
				"<cmd>NvimTreeToggle<cr>",
				desc = "NvimTree Toggle",
			},
			{
				"<leader>nf",
				"<cmd>NvimTreeFindFileToggle<cr>",
				desc = "NvimTree Find File",
			},
		},
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			"nvim-telescope/telescope-fzy-native.nvim",
		},
		keys = {
			{ "<leader>,", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>sr", "<cmd>Telescope live_grep<cr>", desc = "Find in files" },
			{ ";", "<cmd>Telescope buffers sort_lastused=true ignore_current_buffer=true<cr>", desc = "Switch buffer" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
			-- {
			-- 	"<leader>ss",
			-- 	Util.telescope("lsp_document_symbols", {
			-- 		symbols = {
			-- 			"Class",
			-- 			"Function",
			-- 			"Method",
			-- 			"Constructor",
			-- 			"Interface",
			-- 			"Module",
			-- 			"Struct",
			-- 			"Trait",
			-- 			"Field",
			-- 			"Property",
			-- 		},
			-- 	}),
			-- 	desc = "Goto Symbol",
			-- },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			-- Use fzy_native
			require("telescope").load_extension("fzy_native")
		end,
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<c-t>"] = function(...)
							return require("trouble.providers.telescope").open_with_trouble(...)
						end,
						-- ["<a-i>"] = function()
						-- 	Util.telescope("find_files", { no_ignore = true })()
						-- end,
						-- ["<a-h>"] = function()
						-- 	Util.telescope("find_files", { hidden = true })()
						-- end,
						["<C-Down>"] = function(...)
							return require("telescope.actions").cycle_history_next(...)
						end,
						["<C-Up>"] = function(...)
							return require("telescope.actions").cycle_history_prev(...)
						end,
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = "BufReadPost",
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Schrink selection", mode = "x" },
		},
		---@type TSConfig
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"help",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"vim",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		},
	},
}

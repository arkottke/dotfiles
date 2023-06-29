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
    }
  },
  {
    "ggandor/leap.nvim",
    dependencies = { { "tpope/vim-repeat" } },
    config = function()
      require('leap').add_default_mappings(true)
    end,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    -- event = "BufReadPre",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {                            -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },                  -- Required
      { "hrsh7th/cmp-nvim-lsp" },              -- Required
      { "hrsh7th/cmp-buffer" },                -- Optional
      { "hrsh7th/cmp-path" },                  -- Optional
      { "saadparwaiz1/cmp_luasnip" },          -- Optional
      { "hrsh7th/cmp-nvim-lua" },              -- Optional

      -- Snippets
      { "L3MON4D3/LuaSnip",                 dependencies = { "rafamadriz/friendly-snippets" } }, -- Required
    },
    config = function()
      local lsp = require("lsp-zero").preset({}) -- Have pyright use environmental variable

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      lsp.setup()

      -- Add friendly snippets
      require('luasnip.loaders.from_vscode').lazy_load()
      -- Add custom snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })

      -- You need to setup `cmp` after lsp-zero
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        mapping = {
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }
      })

      -- -- Modify tab completion
      -- local cmp = require('cmp')
      -- local cmp_action = require('lsp-zero').cmp_action()

      -- cmp.setup({
      --   mapping = {
      --     ['<Tab>'] = cmp_action.luasnip_supertab(),
      --     ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
      --   }
      -- })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = true,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.completion.spell,
        },
      })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
      extensions = { 'neo-tree', 'lazy', 'fugitive', 'trouble', }
    }
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
        { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding" },
        { opts.mappings.find,           desc = "Find right surrounding" },
        { opts.mappings.find_left,      desc = "Find left surrounding" },
        { opts.mappings.highlight,      desc = "Highlight surrounding" },
        { opts.mappings.replace,        desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      -- use ms mappings instead of s to prevent conflict with leap
      mappings = {
        add = "gza",            -- Add surrounding in Normal and Visual modes
        delete = "gzd",         -- Delete surrounding
        find = "gzf",           -- Find surrounding (to the right)
        find_left = "gzF",      -- Find surrounding (to the left)
        highlight = "gzh",      -- Highlight surrounding
        replace = "gzr",        -- Replace surrounding
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
      { "<leader>zd", "<cmd>ZkNew { dir = 'weekly', date = 'today' }<cr>",  desc = "New diary" },
      { "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' } }<cr>",         desc = "Open note" },
      { "<leader>zt", "<cmd>ZkTags<cr>",                                    desc = "Open note by tag" },
      {
        "<leader>zf",
        "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<cr>",
        desc = "Open note by query",
      },
      { "<leader>zf", ":'<,'>ZkMatch<cr>", mode = "v", desc = "Find tag" },
    },
  },
  { "tpope/vim-fugitive" },
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
      { "<leader>,",  "<cmd>Telescope find_files<cr>",                                            desc = "Find files" },
      { "<leader>sr", "<cmd>Telescope live_grep<cr>",                                             desc = "Find in files" },
      { ";",          "<cmd>Telescope buffers sort_lastused=true ignore_current_buffer=true<cr>", desc = "Switch buffer" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                             desc = "Search help" },
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
        file_ignore_patterns = {
          "%.npz",
          "%.pyc",
          "%.7z",
          "%.docx",
          "%.pdf",
        },
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
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },
}

return {
  -- Track the plugin system
  "folke/lazy.nvim",
  {
    "mickael-menu/zk-nvim",
    event = "BufReadPost",
    opts = {
      picker = "telescope",
    },
    config = function(_, opts)
      require('zk').setup(opts)
    end,
    keys = {
      { "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", desc = "New note" },
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
    'phaazon/mind.nvim',
    event = "VimEnter",
    dependencies = {
      'nvim-lua/plenary.nvim',
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
  "tpope/vim-fugitive",
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
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
            annotation_convention = "numpydoc"
          }
        }
      }
    }
},
  { "lervag/vimtex", lazy = true, ft = "tex" },
  {
    'Tummetott/reticle.nvim',
    lazy = "BufReadPost",
    config = true
  }
}

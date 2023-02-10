return {
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
    require('telescope').setup(opts)
    -- Use fzy_native
    require('telescope').load_extension('fzy_native')
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
}

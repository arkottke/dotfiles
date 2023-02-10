return {
	"nvim-tree/nvim-tree.lua",
	name = "nvim-tree", event = "VimEnter",
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
}

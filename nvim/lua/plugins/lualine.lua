return {
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
}

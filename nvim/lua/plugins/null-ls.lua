return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = { "mason.nvim" },
	keys = {
		{ "<leader>lf", vim.lsp.buf.format, desc = "Format" },
	},
	opts = function()
		local nls = require("null-ls")
		return {
			sources = {
				nls.builtins.code_actions.gitsigns,
				nls.builtins.diagnostics.flake8,
				nls.builtins.formatting.black,
				nls.builtins.formatting.bibclean,
				nls.builtins.formatting.prettierd,
				nls.builtins.formatting.stylua,
				nls.builtins.diagnostics.chktex,
				nls.builtins.diagnostics.rstcheck,
			},
		}
	end,
}

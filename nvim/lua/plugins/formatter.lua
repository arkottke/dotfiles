require("formatter").setup({
	filetype = {
		bib = {
			function()
				return {
					exe = "bibclean", -- this should be available on your $PATH
					args = { "-align-equals" },
					stdin = true,
				}
			end,
		},
    c = {
      require('formatter.filetypes.c').clangformat,
    },
    cpp = {
      require('formatter.filetypes.cpp').clangformat,
    },
    json = {
      require('formatter.filetypes.json').prettierd,
    },
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
    python = {
      require('formatter.filetypes.python').black,
    },
		sh = {
			-- Shell Script Formatter
			function()
				return {
					exe = "shfmt",
					args = { "-i", 2 },
					stdin = true,
				}
			end,
		},
		tex = {
			function()
				return {
					exe = "latexindent",
					args = { "-" },
					stdin = true,
				}
			end,
		},
    toml = {
      require('formatter.filetypes.toml').taplo,
    },
    yaml = {
      require('formatter.filetypes.yaml').prettierd,
    },
		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

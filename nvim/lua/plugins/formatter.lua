require('formatter').setup({
  filetype = {
    bib = {
      function()
        return {
          exe = "bibclean", -- this should be available on your $PATH
          args = {"-align-equals"},
          stdin = true
        }
      end
    },
    cpp = {
      -- clang-format
      function()
        return {
          exe = "clang-format",
          args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
        }
      end
    },
    json = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
          stdin = true
        }
      end
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = {
            "--config-path "
            .. os.getenv("XDG_CONFIG_HOME")
            .. "/stylua/stylua.toml",
            "-",
          },
          stdin = true,
        }
      end,
    },
    python = {
      -- Configuration for psf/black
      function()
        return {
          exe = "black", -- this should be available on your $PATH
          args = { '-' },
          stdin = true,
        }
      end
    }
    sh = {
      -- Shell Script Formatter
      function()
        return {
          exe = "shfmt",
          args = { "-i", 2 },
          stdin = true,
        }
      end,
    }
  }
})

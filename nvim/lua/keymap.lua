local wk = require("which-key")


local keymaps = {
  mode = { "n", "v" },
  ["]"] = { name = "+next" },
  ["["] = { name = "+prev" },
  ["<leader>"] = {
    c = {
      name = "+plugin",
      l = { "<cmd>Lazy sync<cr>", "Lazy sync" },
    },
    l = { name = "+lsp" },
    n = { name = "+nvimtree" },
    s = { name = "+search" },
    x = { name = "+trouble" },
    z = { name = "+search" },
  }
}

wk.register(keymaps)

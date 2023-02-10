return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  config = function()
    require("lspsaga").setup({})
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  keys = {
    { '<leader>o', '<cmd>Lspsaga outline<cr>', desc = 'Outline' }
  }
}

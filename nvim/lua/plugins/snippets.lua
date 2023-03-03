return {
  {
    "L3MON4D3/LuaSnip",
    event = "BufReadPre",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      update_events = "TextChanged,TextChangedI",
    },
    init = function()
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
    end,
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,   mode = "s" },
      { "<s-tab>", function() require("luasnip").jump( -1) end, mode = { "i", "s" } },
      { "<leader>L",
        function() require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" }) end,
        expr = true, mode = { "s" }
      },
    },
  },
}

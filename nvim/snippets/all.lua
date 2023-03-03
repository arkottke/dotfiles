-- Abbreviations used in this article and the LuaSnip docs
-- Based on: https://www.ejmastnak.com/tutorials/vim-latex/luasnip/
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial


return {
  s(
    { trig = 'date', dscr = 'Date' },
    p(os.date, '%Y-%m-%d')
  ),
  s(
    { trig = 'datetime', dscr = 'Date time' },
    p(os.date, '%Y-%m-%d %H:%M')
  )
}

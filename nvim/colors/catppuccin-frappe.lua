-- Hand-rolled Catppuccin Frappé colorscheme (no plugin manager here, so the
-- real catppuccin/nvim plugin isn't available -- this covers the highlight
-- groups this config's builtins/lua/custom modules actually touch).
-- Palette: https://github.com/catppuccin/catppuccin

vim.cmd 'hi clear'
if vim.fn.exists 'syntax_on' then vim.cmd 'syntax reset' end
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.g.colors_name = 'catppuccin-frappe'

local p = {
  rosewater = '#f2d5cf',
  flamingo = '#eebebe',
  pink = '#f4b8e4',
  mauve = '#ca9ee6',
  red = '#e78284',
  maroon = '#ea999c',
  peach = '#ef9f76',
  yellow = '#e5c890',
  green = '#a6d189',
  teal = '#81c8be',
  sky = '#99d1db',
  sapphire = '#85c1dc',
  blue = '#8caaee',
  lavender = '#babbf1',
  text = '#c6d0f5',
  subtext1 = '#b5bfe2',
  subtext0 = '#a5adce',
  overlay2 = '#949cbb',
  overlay1 = '#838ba7',
  overlay0 = '#737994',
  surface2 = '#626880',
  surface1 = '#51576d',
  surface0 = '#414559',
  base = '#303446',
  mantle = '#292c3c',
  crust = '#232634',
}

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- Core UI
hl('Normal', { fg = p.text, bg = p.base })
hl('NormalFloat', { fg = p.text, bg = p.mantle })
hl('FloatBorder', { fg = p.overlay0, bg = p.mantle })
hl('SignColumn', { bg = p.base })
hl('CursorLine', { bg = p.surface0 })
hl('CursorLineNr', { fg = p.yellow, bold = true })
hl('LineNr', { fg = p.surface1 })
hl('Visual', { bg = p.surface2 })
hl('Search', { fg = p.crust, bg = p.yellow })
hl('IncSearch', { fg = p.crust, bg = p.peach })
hl('MatchParen', { fg = p.peach, bold = true })
hl('Pmenu', { fg = p.text, bg = p.surface0 })
hl('PmenuSel', { fg = p.crust, bg = p.blue })
hl('PmenuSbar', { bg = p.surface1 })
hl('PmenuThumb', { bg = p.overlay0 })
hl('StatusLine', { fg = p.text, bg = p.surface0 })
hl('StatusLineNC', { fg = p.overlay0, bg = p.mantle })
hl('WinSeparator', { fg = p.surface1 })
hl('Directory', { fg = p.blue })
hl('Title', { fg = p.blue, bold = true })
hl('NonText', { fg = p.surface1 })
hl('Whitespace', { fg = p.surface1 })
hl('Folded', { fg = p.overlay1, bg = p.surface0 })
hl('ColorColumn', { bg = p.surface0 })
hl('WildMenu', { fg = p.crust, bg = p.blue })

-- Syntax
hl('Comment', { fg = p.overlay1, italic = true })
hl('String', { fg = p.green })
hl('Character', { fg = p.teal })
hl('Number', { fg = p.peach })
hl('Boolean', { fg = p.peach })
hl('Float', { fg = p.peach })
hl('Identifier', { fg = p.text })
hl('Function', { fg = p.blue })
hl('Statement', { fg = p.mauve })
hl('Conditional', { fg = p.mauve })
hl('Repeat', { fg = p.mauve })
hl('Keyword', { fg = p.mauve })
hl('Operator', { fg = p.sky })
hl('Exception', { fg = p.mauve })
hl('PreProc', { fg = p.pink })
hl('Include', { fg = p.mauve })
hl('Type', { fg = p.yellow })
hl('StorageClass', { fg = p.yellow })
hl('Structure', { fg = p.yellow })
hl('Special', { fg = p.pink })
hl('SpecialChar', { fg = p.pink })
hl('Constant', { fg = p.peach })
hl('Delimiter', { fg = p.overlay2 })
hl('Underlined', { underline = true })
hl('Error', { fg = p.red })
hl('Todo', { fg = p.crust, bg = p.yellow, bold = true })

-- Diagnostics
hl('DiagnosticError', { fg = p.red })
hl('DiagnosticWarn', { fg = p.yellow })
hl('DiagnosticInfo', { fg = p.sky })
hl('DiagnosticHint', { fg = p.teal })
hl('DiagnosticUnderlineError', { undercurl = true, sp = p.red })
hl('DiagnosticUnderlineWarn', { undercurl = true, sp = p.yellow })
hl('DiagnosticUnderlineInfo', { undercurl = true, sp = p.sky })
hl('DiagnosticUnderlineHint', { undercurl = true, sp = p.teal })

-- LSP
hl('LspReferenceText', { bg = p.surface1 })
hl('LspReferenceRead', { bg = p.surface1 })
hl('LspReferenceWrite', { bg = p.surface1 })
hl('LspInlayHint', { fg = p.overlay1, bg = p.surface0 })

-- Diff / git (used by lua/custom/gitsigns.lua)
hl('DiffAdd', { fg = p.green, bg = p.base })
hl('DiffChange', { fg = p.yellow, bg = p.base })
hl('DiffDelete', { fg = p.red, bg = p.base })
hl('DiffText', { fg = p.blue, bg = p.surface0 })
hl('GitSignsAdd', { fg = p.green })
hl('GitSignsChange', { fg = p.yellow })
hl('GitSignsDelete', { fg = p.red })

-- Spelling
hl('SpellBad', { undercurl = true, sp = p.red })
hl('SpellCap', { undercurl = true, sp = p.yellow })
hl('SpellRare', { undercurl = true, sp = p.pink })
hl('SpellLocal', { undercurl = true, sp = p.teal })

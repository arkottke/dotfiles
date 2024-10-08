-----------------------------------------------------------
-- Neovim settings
-- Based on: https://github.com/brainfucksec/neovim-lua
-----------------------------------------------------------

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd            -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn              -- call Vim functions
local g = vim.g                -- global variables
local opt = vim.opt            -- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
--- g.mapleader = ','             -- change leader to a comma
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile

if fn.executable('rg') == 1 then
  opt.grepprg = 'rg --vimgrep --no-heading'
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

opt.spellfile = '~/.config/nvim/spell/en.utf-8.add'

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true                      -- show line number
opt.showmatch = true                   -- highlight matching parenthesis
opt.foldmethod = 'marker'              -- enable folding (default 'foldmarker')
opt.splitright = true                  -- vertical split to the right
opt.splitbelow = true                  -- orizontal split to the bottom
opt.ignorecase = true                  -- ignore case letters when search
opt.smartcase = true                   -- ignore lowercase for the whole pattern
opt.linebreak = true                   -- wrap on word boundary
opt.guifont = 'Hack Nerd Font Mono:h7' -- GUI font
opt.cursorline = true                  -- Cursorline

-- opt.formatoptions = 'croq'
opt.wildignore:append {
  '*.swp',
  '*.zip',
  '*.tar.gz',
  '*.7z',
  '*.exe',
  '*.pdf',
  '*.docx',
  '*.xlsx',
  -- Python files
  '*.egg-info/',
  '*.pyc',
  '__pycache__/',
  '.pytest_cache/',
  '*.whl',
  '.ipynb_checkpoints/',
  '_build/'
}

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

cmd [[au BufWritePre * lua vim.lsp.buf.format()]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true     -- enable background buffers
opt.history = 200     -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240   -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true -- enable 24-bit RGB colors
cmd [[colorscheme catppuccin-frappe]]

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true   -- use spaces instead of tabs
opt.shiftwidth = 4     -- shift 4 spaces when tab
opt.tabstop = 4        -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,json setlocal shiftwidth=2 tabstop=2
]]


-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
-- insert mode completion options
opt.completeopt = 'menu,menuone,noselect'

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- disable nvim intro
opt.shortmess:append "sI"

call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes
Plug 'junegunn/vim-plug'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}

Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'psf/black'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

let mapleader=","
let maplocalleader=",,"

set autoindent
set backspace=indent,eol,start
set complete-=i
set completeopt=menuone,noinsert,noselect
set cursorline
set expandtab
set number
set ruler
set shellslash
set shiftwidth=4 	" auto-ident width when using cindent
set softtabstop=4 	" spaces added when hitting tab
set tabstop=8 		" real tab width
set termguicolors
set wildmode=longest,list,full
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git*

colorscheme nord
let g:lightline#colorscheme = 'nord'

" Denite configuruation
""""""""""""""""""""""""
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

call denite#custom#map(
      \ 'insert',
      \ '<C-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

" Ripgrep command on grep source
call denite#custom#var('grep', {
            \ 'command': ['rg'],
            \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
            \ 'recursive_opts': [],
            \ 'pattern_opt': ['--regexp'],
            \ 'separator': ['--'],
            \ 'final_opts': [],
            \ })

call denite#custom#var('file/rec', 'command',
            \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])

call denite#custom#source('file/rec', 'matchers', 
            \ ['matcher/fuzzy', 'matcher/hide_hidden_files', 'matcher/ignore_globs'])

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
              \ [ '*~', '*.o', '*.exe', '*.bak', '*.png', '*.pdf', '*.jpg', 
              \   '*.pyc', '*.sw[po]', '*.class', '.hg/', '.git/', '.bzr/', 
              \   '.svn/', 'tags', 'tags-*', '__pycache__/'])

let s:denite_options = {
      \ 'prompt' : '❯',
      \ 'start_filter': 1,
      \ 'auto_resize': 1,
      \ 'source_names': 'short',
      \ 'direction': 'botright',
      \ 'reversed': 'true',
      \ }
call denite#custom#option('default', s:denite_options)

nmap ; :Denite buffer<CR>
nmap <Leader>t :Denite file/rec<CR>
nmap <Leader>r :Denite tag<CR>
nmap <Leader>e :Denite grep<CR>

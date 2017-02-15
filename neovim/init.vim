execute pathogen#infect()
syntax on
filetype plugin indent on

colorscheme dracula

" Deoplete
" """"""""
" Use deoplete
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" Denite
" """"""
" Use pt which supports linux and windows
call denite#custom#var('file_rec', 'command',
\ ['pt', '--follow', '--nocolor', '--nogroup', '-g:', ''])
" Find the git directory
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
" Change mappings.
call denite#custom#map(
\ 'insert',
\ '<C-j>',
\ '<denite:move_to_next_line>',
\ 'noremap'
\)
call denite#custom#map(
\ 'insert',
\ '<C-k>',
\ '<denite:move_to_previous_line>',
\ 'noremap'
\)

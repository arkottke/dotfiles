" Allow for lines to be broken as I type.
set formatoptions-=l

set textwidth=80

" Enable spelling
setlocal spell spelllang=en_us

" F5 to create a pdf
nmap <buffer> <F5> :!rst2pdf %<CR>

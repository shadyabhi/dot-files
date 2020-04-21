autocmd FileType <python> autocmd BufWritePre <buffer> StripWhitespace
autocmd FileType py :set expandtab
set tabstop=4
set softtabstop=4
set autoindent shiftwidth=4
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

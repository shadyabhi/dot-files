" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
let g:syntastic_aggregate_errors = 1
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

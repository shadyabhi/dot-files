map <C-j> :cn<CR>
map <C-k> :cp<CR>

" Always open new Quickfix list on bottom (when vertical widows are present)
autocmd FileType qf wincmd J | resize 5

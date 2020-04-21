set number
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

" Colorscheme
colorscheme atom-dark-256

" To close preview window of deoplete automagically
autocmd CompleteDone * pclose


" Remember last-open cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Auto save
map <M-s> :w<kEnter>  "Works in normal mode, must press Esc first"
imap <M-s> <Esc>:w<kEnter>i "Works in insert mode, saves and puts back in insert mode"

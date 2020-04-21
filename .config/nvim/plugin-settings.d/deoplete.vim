let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
" Complete via <TAB>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Go stuff
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#use_cache = 1
if system('uname -s') == "Darwin\n"
	let g:deoplete#sources#go#json_directory = '/Users/arastogi/cache/deoplete/go/cache'
else
	let g:deoplete#sources#go#json_directory = '/home/arastogi/.cache/deoplete/go/cache'
endif


" Python stuff
" Make sure neovim & jedi module is installed ona ll these locations
" wget https://bootstrap.pypa.io/get-pip.py
" sudo /export/apps/python/2.7/bin/python ~/get-pip.py
" sudo /export/apps/python/3.5/bin/python3 ~/get-pip.py
" sudo /export/apps/python/3.5/bin/pip install neovim
" sudo /export/apps/python/2.7/bin/pip install neovim
let g:python3_host_prog  = '/Users/arastogi/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog  = '/Users/arastogi/.pyenv/versions/neovim2/bin/python'
let g:deoplete#sources#jedi#python_path = '/Users/arastogi/.pyenv/versions/neovim3/bin/python'


" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

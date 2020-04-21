" Build on save
autocmd BufWritePost *.go :GoBuild

" Go specific shortcuts
autocmd FileType go map <leader>r :GoRun<CR>
autocmd FileType go map <leader>d :GoDecls<CR>
autocmd FileType go map <leader>D :GoDocBrowser<CR>

" List size in quickfic window
let g:go_list_height = 15
let g:go_term_mode = "split"
" Enable highlighting of current variable in viewport
let g:go_auto_sameids = 1
" Auto show type info for a variable
let g:go_auto_type_info = 1
"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_deadline = "10s"
" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'gas']
let g:go_def_mode = 'godef'

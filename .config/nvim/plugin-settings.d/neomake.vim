autocmd! BufWritePost * Neomake


let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_go_gometalinter_args = ['--enable-all', '-j', '2']

" Don't use neomake for Python, we have python-mode
let g:neomake_python_enabled_makers = []

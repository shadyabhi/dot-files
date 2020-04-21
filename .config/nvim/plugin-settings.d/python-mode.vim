" python-mode
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 0

let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint', 'pep257']
let g:pymode_lint_ignore = ["E501","D400"]

let g:pymode_lint_signs = 1
let g:pymode_lint_unmodified = 1
let g:pymode_lint_on_fly = 0

let g:pymode_trim_whitespaces = 1

let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'

let g:pymode_virtualenv = 1

let g:pymode_breakpoint_bind = '<leader>b'

" Don't open new window
let g:pymode_rope_goto_definition_cmd = 'e'
" Don't do lookups, they're slow
let g:pymode_rope_lookup_project = 0
" As we do auto-compelte using deoplete-jedi
let g:pymode_rope_complete_on_dot = 0

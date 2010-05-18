set tabstop=4
set shiftwidth=4
set smarttab
set expandtab " spaces, not tabs
set smartindent
set foldlevel=99 
set foldmethod=indent
let python_highlight_space_errors=1
let python_highlight_numbers=1
set enc=utf8
"set noexpandtab " tabs, no spaces

hi link pythonBuiltin pythonConditional

" comment are comment, not C stuff :p
inoremap # X#

" ruby-like symbols for python
vmap tp :s/:\([-a-z0-9_]\+\)/"\1"/ig<CR>

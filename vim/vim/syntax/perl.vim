set expandtab
set smarttab
set number
let perl_fold=1
let perl_fold_blocks=1
set foldmethod=syntax
set foldlevel=99
set complete=.,w,b,u,t

" perltidy
vmap tv !perltidy -ce -q <CR>
nmap tv !perltidy -ce -q <CR>


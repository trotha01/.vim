let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['govet', 'gofmt', 'go']

let mapleader = "g"

" Open go source definition
nmap <Leader>dd <Plug>(go-def-split)
nmap <Leader>dv <Plug>(go-def-vertical)
nmap <Leader>dt <Plug>(go-def-tab)

" Open go documentation
nmap <Leader>cf <Plug>(go-doc)
nmap <Leader>cc <Plug>(go-doc-split)
nmap <Leader>cv <Plug>(go-doc-vertical)

" Open fo doc in a browser
nmap <Leader>gb <Plug>(go-doc-browser)

" Open interfaces that an item implements
nmap <Leader>s <Plug>(go-implements)

" Show item info
nmap <Leader>f <Plug>(go-info)

" rename
nmap <Leader>e <Plug>(go-rename)

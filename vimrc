"""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC (pieces picked from multiple sources, primarily
" "   http://www.vim.org/scripts/script.php?script_id=760
" "   http://amix.dk/vim/vimrc.html
" "   http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
"
" " Catered to the needs and woes of a Tufts University Comp40 student
" " Contact Marshall @ mmoutenot@gmail.com with questions or comments.
"""""""""""""""""""""""""""""""""""""""""""""""""""

set diffopt=filler,vertical

let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" OPTIONS {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Add fuzzy finder
" set rtp+=~/.fzf

set nocompatible " not compatible with vi
set number " line numbers
set showcmd " show :command at bottom
set cmdheight=2 " Command line height

" set paste " Copy and paste into vim normally
set mouse=a " Enable use of the mouse

syntax on "Syntax highlighting
filetype on "Filetype detection
filetype plugin on " filetype plugins
filetype indent on " filetype specific indenting

set autoread " read a file when it is changed from the outside

" Use grep
" TODO: --color doesn't work?
set grepprg=internal

" Open split to right
set splitright

" Change tab to space characters
set expandtab " Use spaces for a tab
set smarttab " Smartly determines # of spaces to use
set shiftwidth=2 " number of spaces to use for autoindent
set softtabstop=2 " number of spaces to use for indents
set backspace=2 " Allow backspace over autoindents/line breaks/start of insert
set autoindent " Autoindent on a new line
set cpoptions+=I " Don't autoremove autoindent if not used


" Spell checking (default=false)
if version >= 700 " vim version 7.0 and up
  set spl=en spell
  set nospell
endif

" For latex files
let g:tex_flavor='latex'

" When searching
set ignorecase " ignores case when searching
set smartcase " ignores case when searching, unless pattern contains uppercase
set incsearch " match as you type
set hlsearch " search highlighting
set nolazyredraw " keep redrawing screen (keep syntax highlighting)

set guioptions-=T " remove toolbar
set t_Co=256 " terminal colors
set encoding=utf8

set ffs=unix,dos,mac " Default file types

" Status line gnarliness
set ruler " show current row/column
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ \ \ Line:\ %l/%L:%c

" Remove fillchars (used to fill statuslines and vertical separators)
set fillchars=

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

try
  lang en_US
catch
endtry

" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<tab>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<s-tab>', '<Up>']

" let g:UltiSnipsExpandTrigger = "<C-l>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" END OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" BUNDLES {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

" Syntastic options (for lnext lprev to work)
let g:syntastic_always_populate_loc_list = 1

" helptags
:helptags ~/.vim/doc

" END BUNDLES
"""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" VARIABLES {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "."

" For linux clipboard register
let g:clipbrdDefaultReg = '+'

" Check syntax on open
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
" Error symbols
let g:syntastic_error_symbol='x'
let g:syntastic_warning_symbol = '!'
" Checker type
" let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_checkers = ['gjslint']
" END VARIABLES
"""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" SYNTAX {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Solarized
syntax enable "Enable syntax hl
set background=dark " Vim will try to use colors for a dark background
let g:solarized_termcolors=256
colorscheme solarized
call togglebg#map("<F5>") " F5 will toggle the solarized colorscheme

" Nicer vimdiff
let g:solarized_diffmode="high"

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

" END SYNTAX
"""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" AUTOCMDS {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically cd to current directory
" backwards compatible
augroup DirectoryChange
  au!
  autocmd BufEnter * silent! lcd %:p:h
augroup END

" help template
augroup templates
  au!
  autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.txt
  " autocmd BufNewFile *.c silent! !cat $HOME/.vim/templates/make.c.txt >> Makefile
  " autocmd BufNewFile *.cpp silent! !cat $HOME/.vim/templates/make.cpp.txt >> Makefile
augroup END

" markdown Formatting
augroup markdown
    autocmd FileType markdown set textwidth=80 formatoptions+=twan
    autocmd FileType markdown set nopaste spell
augroup End

" Allow tabs in makefiles and .calendar
augroup tabs
    au!
    autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
    autocmd FileType calendar setlocal noexpandtab shiftwidth=8 softtabstop=0
    autocmd BufWinEnter .calendar setlocal noexpandtab shiftwidth=8 softtabstop=0
augroup END


" Remove any trailing whitespace that is in the file
" Don't remove if file is '.md' or '.vim' file
augroup FileEdit
  au!
  autocmd BufRead,BufWrite *
    \ if ! &bin && ! &ft =~ 'markdown' && ! &ft =~ 'vim'|
    \   silent! %s/\s\+$//ge |
    \ endif
augroup END

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
        \ if expand("<afile>:p:h") !=? $TEMP |
        \   if line("'\"") > 1 && line("'\"") <= line("$") |
        \     let JumpCursorOnEdit_foo = line("'\"") |
        \     let b:doopenfold = 1 |
        \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
        \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
        \        let b:doopenfold = 2 |
        \     endif |
        \     exe JumpCursorOnEdit_foo |
        \   endif |
        \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter * silent
        \ if exists("b:doopenfold") |
        \   exe "normal zv" |
        \   if(b:doopenfold > 1) |
        \       exe  "+".1 |
        \   endif |
        \   unlet b:doopenfold |
        \ endif
augroup END

" :au[tocmd] [group] {event} {pat} [nested] {cmd}
" Reloads vimrc on save
augroup reload
  au!
  autocmd BufWritePost .vimrc call ReloadVimrc()
augroup END

augroup autoindent
    au!
    " autocmd BufWritePre *.scss :normal migg=G`izz
    " autocmd BufWritePre *.hbs :normal migg=G`izz
augroup End

augroup WhitespaceColors
  au!
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=green guibg=green
augroup END

" Autocompile markdown to html
augroup maruku
  au!
  " autocmd BufWritePost *.md !maruku <afile>
  " autocmd BufWritePost *.md !maruku <afile>:r //TODO: download maruku
augroup END

augroup quickFix
    au!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END

augroup tex
    au!
    " autocmd BufWritePost *.tex !latex %
    autocmd BufWritePost *.tex !pdflatex %
augroup END

" Reading/Writing gzip files (From vim help file)
augroup gzip
  autocmd!
  autocmd BufReadPre,FileReadPre	*.gz set bin
  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost	*.gz set nobin
  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")
  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

  autocmd FileAppendPre		*.gz !gunzip <afile>
  autocmd FileAppendPre		*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost		*.gz !gzip <afile>:r
augroup END

" END AUTOCMDS
"""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" COMMANDS {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=1 Grep :call Grep("<args>")
" END COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" MAPPINGS {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Esc
" imap fj <Esc>
" imap jf <Esc>

" Screen navigation
nnoremap <c-j> <c-e>
nnoremap <c-k> <c-y>

" Map marker jumping to cursor, not line
nmap ' `

" Easier folding block
nnoremap z{ zfa{
nnoremap z} zfa{

nnoremap z[ zfa{
nnoremap z] zfa{

" Key navigation
nnoremap j gj
nnoremap k gk

" Find syntax highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Other remaps
noremap <Leader>n :set nopaste<cr>
noremap <Leader>p :set paste<cr>
noremap <Leader>r :set rnu<cr>
noremap <Leader>u :set rnu!<cr>
noremap <Leader>vi :tabe $HOME/.vim/vimrc<CR>

" Open Url with the browser \w
map <Leader>w :call Browser()<CR>

" Folds html tags
nnoremap <leader>ft Vatzf

" Next Tab
noremap <silent> <C-Right> :tabnext<CR>
" Previous Tab
noremap <silent> <C-Left> :tabprevious<CR>
" New Tab
" noremap <silent> <C-t> :tabnew<CR>

" Centers the next result on the page
map N Nzz
map n nzz

" Move up and down easier
let g:C_Ctrl_j = 'off'
nmap <C-j> <C-d>
nmap <C-k> <C-u>

" resize current buffer by +/- 5
nnoremap <S-left> :vertical resize -5<cr>
nnoremap <S-down> :resize +5<cr>
nnoremap <S-up> :resize -5<cr>
nnoremap <S-right> :vertical resize +5<cr>

" switch between windows with Ctrl-[h,j,k,l]
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Tagbar mapp
:command! -nargs=0 TT TagbarToggle

" Reload vimrc on command
noremap <leader>rv <Esc>:call ReloadVimrc()<CR>

" open ultisnips file
noremap <leader>sn :UltiSnipsEdit

" END MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" FUNCTIONS {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""
"See syntax highlighting
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction
set statusline+=%=
set statusline+=%{SyntaxItem()}

" Open URL in Browser {{{
function! Browser()
  let line = getline (".")
  let a:url = matchstr (line,"http[^  ]*")
  " exec "!chrome ".line

  if IsWin()
      let cmd = '!start rundll32 url.dll,FileProtocolHandler %URL%'
  elseif has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin'
      let cmd = 'open %URL%'
  elseif executable('xdg-open')
      let cmd = 'xdg-open %URL%'
  elseif executable('firefox')
      let cmd = 'firefox %URL% &'
  else
      let cmd = ''
  endif

  if len(cmd) == 0
      redraw
      echohl WarningMsg
      echo "It seems that you don't have general web browser. Open URL below."
      echohl None
      echo a:url
      return
  endif

  if cmd =~ '^:[A-Z]'
      let cmd = substitute(cmd, '%URL%', '\=a:url', 'g')
      exec cmd
  else
      let cmd = substitute(cmd, '%URL%', '\=shellescape(a:url)', 'g')
      call system(cmd)
  endif
endfunction
"}}}

function! Grep(name)
  let l:pattern = input("Other pattern: ")
  "let l:_name = substitute(a:name, "\\s", "*", "g")
  let l:list=system("grep -nIR '".a:name."' * | grep -v 'svn-base' | grep '" .l:pattern. "' | cat -n -")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif

  echo l:list
  let l:input=input("Which?\n")

  if strlen(l:input)==0
    return
  endif

  if strlen(substitute(l:input, "[0-9]", "", "g"))>0
    echo "Not a number"
    return
  endif

  if l:input<1 || l:input>l:num
    echo "Out of range"
    return
  endif

  let l:line=matchstr("\n".l:list, "".l:input."\t[^\n]*")
  let l:lineno=matchstr(l:line,":[0-9]*:")
  let l:lineno=substitute(l:lineno,":","","g")
  "echo "".l:line
  let l:line=substitute(l:line, "^[^\t]*\t", "", "")
  "echo "".l:line
  let l:line=substitute(l:line, "\:.*", "", "")
  "echo "".l:line
  "echo "\n".l:line
  execute ":e ".l:line
  execute "normal ".l:lineno."gg"
endfunction

"{{{ Reload vimrc
  " Doesn't reload ReloadVimrc function itself (Which is a good thing)
  " Reset options to defaults
  " Clear all local commands
  " Clear all abbreviations
  " Clear all mappings
  " :source vimrc's
if !exists("*ReloadVimrc")
  function! ReloadVimrc()
    set all&
    set guioptions-=T
    " comclear
    abclear
    mapclear
    xmapclear
    smapclear
    mapclear!
    lmapclear
    so $MYVIMRC
    set filetype=vim
  endfunction
endif
" }}}

" END FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" TODO: figure out actual solarize fix
ToggleBG


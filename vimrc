
"""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC (pieces picked from multiple sources, primarily
" "   http://www.vim.org/scripts/script.php?script_id=760
" "   http://amix.dk/vim/vimrc.html
" "   http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
"
" " Catered to the needs and woes of a Tufts University Comp40 student
" " Contact Marshall @ mmoutenot@gmail.com with questions or comments.
"""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""
" => Options
" => Bundles
" => Variables
" => Syntax
" => Autocmds
" => Commands
" => Mappings
" => Quickfix
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set number "line numbers
set showcmd "show :command at bottom
set cmdheight=2

filetype off " necessary for ftdetect to work
syntax on
filetype on
filetype plugin on " filetype plugins
filetype indent on " filetype specific indenting

" Latex-Suite options
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

set autoread " read a file when it is changed from the outside

" Use grep
set grepprg=grep\ -nH\ $*

" Change tab to space characters
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
" YEAH that's right. I started using 2 spaces per tab. That's because when you
" care about good looking code, and you're limiting yourself to 80 cols, EVERY
" SPACE COUNTS.
set backspace=2
set autoindent

" Spell checking (default=false)
if version >= 700 " vim version 7.0 and up
  set spl=en spell
  set nospell
endif

" Tab completion
"set wildmenu
"set wildmode=list:longest,full

" When searching
set ignorecase
set smartcase
set incsearch " match as you type
set hlsearch " search highlighting
set nolazyredraw " keep redrawing screen (keep syntax highlighting)

" Set font according to system
" if you're using a mac
" set gfn=Menlo:h12
" set shell=/bin/bash

" if you're using windows
" set gfn=Bitstream\ Vera\ Sans\ Mono:h10

" if you're using linux
" height 12 points
set gfn=Lucida\ Console:h12
"  set shell=/bin/bash

set guioptions-=T " remove toolbar
set t_Co=256 " terminal colors
set background=dark
set encoding=utf8

set ffs=unix,dos,mac "Default file types

"Status line gnarliness
set ruler "show current row/column
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


silent! call mkdir($HOME."\\.tmp")
" Errors will occur if backup/tmp directory doesn't exist

set backupdir=$HOME/.tmp// " Set directory for backup files
set directory=$HOME/.tmp// " Set directory for swap files
" two slashes keep full path name when file is saved to prevent file
" collisions with files of the same name

"Persistant Undo
"if windows
"set undodir=C:\Windows\Temp
"otherwise
set undodir=~/.tmp/undodir
set undofile                " Save undo's after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Folding Stuffs
" I find this one a little annoying sometimes
" set foldmethod=marker
" set wrap
" set textwidth=80
" let g:RightAlign_RightBorder=80
" if exists('+colorcolumn')
  " set colorcolumn=80
" else
  " au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" endif

try
  lang en_US
catch
endtry

" END OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                   BUNDLES
"""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=$HOME/.vim/bundle/vundle
call vundle#rc('$HOME/.vim/bundle/')

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'ervandew\supertab'
Bundle 'tomtom\tcomment_vim'
Bundle 'tpope\vim-fugitive'
Bundle 'tpope\vim-surround'
Bundle 'wincent\Command-T'
Bundle 'vim-scripts\right_align'

" Snipmate and dependencies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle 'garbas/vim-snipmate'

Bundle 'scrooloose/nerdtree'
Bundle 'rson/vim-conque'
Bundle 'vim-scripts/Align'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/nerdtree-ack'
" END Bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      VARIABLES
"""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "."

" For linux clipboard register
let g:clipbrdDefaultReg = '+'
" END VARIABLES
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      SYNTAX
"""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable "Enable syntax hl
colorscheme ir_black

" Second paren
highlight MatchParen ctermbg=4

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
" The following alternative may be less obtrusive.
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Try the following if your GUI uses a dark background.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

" END SYNTAX
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      AUTOCMDS
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically cd to current directory
" backwards compatible
augroup DirectoryChange
  au!
  autocmd BufEnter * silent! lcd %:p:h
augroup END

augroup templates
  au!
  autocmd BufNewFile * silent! 0r $LOCAL_VIMRC_DIR/templates/%:e.txt
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
  autocmd BufWinEnter *
        \ if exists("b:doopenfold") |
        \   exe "normal zv" |
        \   if(b:doopenfold > 1) |
        \       exe  "+".1 |
        \   endif |
        \   unlet b:doopenfold |
        \ endif
augroup END

augroup reload
  au!
  autocmd BufWritePost vimrc call ReloadVimrc()
augroup END

augroup Colors
  au!
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
augroup END
" END AUTOCMDS
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=1 Grep :call Grep("<args>")
" END COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Split Terminal
noremap <Leader>tt :vsplit \| :ConqueTerm Powershell.exe<CR><ESC><C-w>ri

" GIT Commands
noremap <Leader>gac :Gcommit -m -a ""<LEFT>
noremap <Leader>gc :Gcommit -m ""<LEFT>
noremap <Leader>gs :Gstatus<CR>

" Other remaps
noremap <Leader>n :set nopaste<cr>
noremap <Leader>p :set paste<cr>
noremap <Leader>vi :tabe $HOME/.vim/vimrc<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
noremap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
noremap <Leader>s :split
noremap <Leader>v :vnew
noremap <Leader>t :tabe <C-R><CR>
" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

" Open Url with the browser \w
map <Leader>w :call Browser ()<CR>

" Trigger the above todo mode
noremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Folds html tags
nnoremap <leader>ft Vatzf

" Next Tab
noremap <silent> <C-Right> :tabnext<CR>
" Previous Tab
noremap <silent> <C-Left> :tabprevious<CR>
" New Tab
noremap <silent> <C-t> :tabnew<CR>

" Centers the next result on the page
map N Nzz
map n nzz

" Move up and down easier
let g:C_Ctrl_j = 'off'
nmap <C-j> <C-d>
nmap <C-k> <C-u>

" Swap ; and : (one less keypress)
nnoremap ; :
nnoremap : ;

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
"function! SetArrowKeysAsTextShifters()
  " normal mode
  nmap <silent> <Left> <<
  nmap <silent> <Right> >>
  nnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>
  nnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>
  nnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>
  nnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>
  nnoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>

  " visual mode
  vmap <silent> <Left> <
  vmap <silent> <Right> >
  vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
  vnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>gv
  vnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>gv
  vnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>gv
  vnoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>gv

  " insert mode
  imap <silent> <Left> <C-D>
  imap <silent> <Right> <C-T>
  inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
  inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
  inoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>a
  inoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>a
  inoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>a

  " disable modified versions we are not using
"  nnoremap  <S-Up>     <NOP>
"  nnoremap  <S-Down>   <NOP>
"  nnoremap  <S-Left>   <NOP>
"  nnoremap  <S-Right>  <NOP>
  vnoremap  <S-Up>     <NOP>
  vnoremap  <S-Down>   <NOP>
  vnoremap  <S-Left>   <NOP>
  vnoremap  <S-Right>  <NOP>
  inoremap  <S-Up>     <NOP>
  inoremap  <S-Down>   <NOP>
  inoremap  <S-Left>   <NOP>
  inoremap  <S-Right>  <NOP>
" endfunction
" call SetArrowKeysAsTextShifters()

" resize current buffer by +/- 5
nnoremap <S-left> :vertical resize -5<cr>
nnoremap <S-down> :resize +5<cr>
nnoremap <S-up> :resize -5<cr>
nnoremap <S-right> :vertical resize +5<cr>

" switch between windows with Cmd-[H,J,K,L]
noremap <D-S-H> <C-w>h
noremap <D-S-J> <C-w>j
noremap <D-S-K> <C-w>k
noremap <D-S-L> <C-w>l

" open terminal in vim
noremap <leader>ksh :ConqueTermSplit /bin/ksh<cr>

" DJANGO STUFF
let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \0 :e settings.py<cr>
nnoremap \9 :e urls.py<cr>
map <F8> :vertical wincmd f<CR>

map <leader>g "syiw:Grep^Rs<cr>

noremap <leader>rv <Esc>:call ReloadVimrc()<CR>
" END MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      QUICKFIX
""""""""""""""""""""""""""""""""""""""""""""""""""""
" if MySys() == "Windows"
      " set shell C:/Windows/system32/cmd.exe
  " au FileType cpp set makeprg=g++\ %\ -o\ run
  " "set shellpipe=\ 
  " set makeprg=g++\ %\ -o\ run
  " compiler! gcc
" else
  " set makeprg=./compile " :make runs this script!
" endif
" " END QUICKFIX
"""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""
"                      FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""

"{{{ Open URL in Browser
function! Browser()
  let line = getline (".")
  let line = matchstr (line,"http[^  ]*")
  exec "!chrome ".line
endfunction
"}}}

"{{{ Todo List Mode
function! TodoListMode()
  e ~/.todo.otl
  Calendar
  wincmd l
  set foldlevel=1
  tabnew ~/.notes.txt
  tabfirst
  "or 'norm! zMzr'
endfunction
"}}}

function! CurDir()
  let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
  return curdir
endfunction

function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  else
    return ''
  endif
endfunction

function! DelEmptyLineAbove()
  if line(".") == 1
    return
  endif
  let l:line = getline(line(".") - 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .-1d
    silent normal! <C-y>
    call cursor(line("."), l:colsave)
  endif
endfunction

function! AddEmptyLineAbove()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-e>
  endif
  let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
  if line(".") == line("$")
    return
  endif
  let l:line = getline(line(".") + 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .+1d
    ''
    call cursor(line("."), l:colsave)
  endif
endfunction

function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction

fun! RelatedFile(file)
  #This is to check that the directory looks djangoish
  if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
    exec "edit %:h/" . a:file
    let g:last_relative_dir = expand("%:h") . '/'
    return ''
  endif
  if g:last_relative_dir != ''
    exec "edit " . g:last_relative_dir . a:file
    return ''
  endif
  echo "Cant determine where relative file is : " . a:file
  return ''
endfun

" fun SetAppDir()
"     if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
"         let g:last_relative_dir = expand("%:h") . '/'
"         return ''
"     endif
" endfun
" autocmd BufEnter *.py call SetAppDir()

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
  " Doesn't reload ReloadVimrc function itself
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
"""""""""""""""""""""""""""""""""""""""""""""""""""

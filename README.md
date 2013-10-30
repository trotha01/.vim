Project Forked from mmoutenot/Vimrc  
===================================

Quickstart  
----------

  cd to home directory and git clone https://github.com/trotha01/.vim.git

    $ cd
    $ git clone https://github.com/trotha01/.vim.git

  Add to your global .vimrc or _vimrc:  

    let $LOCAL_VIMRC_DIR = "$HOME\\.vim"
    let $LOCAL_VIMRC = $LOCAL_VIMRC_DIR . "\\vimrc"  
    exec ":set runtimepath+=" . $LOCAL_VIMRC_DIR . ",$VIMRUNTIME"  
    exec ":source" . $LOCAL_VIMRC

Bundles
-------
* [Supertab][]
* [Vim-conque][]
* [Vim-surround][]


  [Git]: http://git-scm.com/downloads
  [Vim]: http://www.vim.org/download.php
  [path]: http://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them
[Vundle]: https://github.com/gmarik/vundle
[Align]: https://github.com/vim-scripts/Align
[Command-T]: https://github.com/wincent/Command-T
[Ack]: https://github.com/mileszs/ack.vim
[Nerdtree]: https://github.com/scrooloose/nerdtree
[Nerdtree-ack]: https://github.com/vim-scripts/nerdtree-ack
[Right\_align]: https://github.com/vim-scripts/right_align
[Snipmate-snippets]: https://github.com/honza/snipmate-snippets
[Supertab]: https://github.com/ervandew/supertab
[Tcomment]: https://github.com/tomtom/tcomment_vim
[Tlib\_vim]: https://github.com/tomtom/tlib_vim
[vim-addon-mw-utils]: https://github.com/MarcWeber/vim-addon-mw-utils
[Vim-conque]: https://github.com/rson/vim-conque
[Vim-fugitive]: https://github.com/tpope/vim-fugitive
[Vim-snipmate]: https://github.com/garbas/vim-snipmate
[Vim-surround]: https://github.com/tpope/vim-surround

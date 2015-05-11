" my filetype file

" If vim already found a filetype, nothing else is needed
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.hbs setfiletype html
  au! BufRead,BufNewFile *.note setfiletype note
augroup END

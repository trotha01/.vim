" Syntax file
" Language: Personal Notes
" Maintainer: Trevor Rothaus 
" Latest Revision: 12 April 2015

if exists("b:current_syntax")
  finish
endif


" Syntax: Keywords
syn keyword Todo TODO FIXME XXX NOTE

" Syntax: http protocol
syn match Type "Response .*"
syn match Type "GET .*"
syn match Type "POST .*"
syn match Type "PUT .*"
syn match Type "PATCH .*"
syn match Statement "+ Headers"
syn match Statement "+ Body"

" Syntax: link
syn match noteLink /http.*/
hi link noteLink Underlined

" Syntax: keywords
" TODO: add #,-,> to iskeyword
syn keyword noteKeywords # ->
hi link noteKeywords Keyword

" Syntax: headers
" TODO: match headers
" syn match title contained '.*'
syn match noteHeader '^#.*'
hi link noteHeader Title


" Syntax: brackets
syn match bracket "{"
syn match bracket "}"
hi link bracket Operator

" Syntax: json region
syn region jsonRegion start="{" end="}" contains=jsonNumber,jsonString,jsonBool
syn region jsonString  start=/"/ end=/"/ contained
syn match jsonNumber "\d\+" contained
syn match jsonBool "true"
hi link jsonNumber Number
hi link jsonString String
hi link jsonBool Boolean

let b:current_syntax = "note"

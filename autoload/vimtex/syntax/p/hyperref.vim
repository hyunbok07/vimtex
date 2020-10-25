" vimtex - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! vimtex#syntax#p#hyperref#load() abort " {{{1
  if has_key(b:vimtex_syntax, 'hyperref') | return | endif
  let b:vimtex_syntax.hyperref = 1

  syntax match texCmd '\\url\ze[^\ta-zA-Z]' nextgroup=texUrlVerb
  syntax region texUrlVerb matchgroup=Delimiter
        \ start='\z([^\ta-zA-Z]\)' end='\z1' contained

  syntax match texCmd '\\url\ze\s*{' nextgroup=texUrl
  syntax region texUrl     matchgroup=Delimiter start='{' end='}' contained

  syntax match texCmd '\\href' nextgroup=texHref
  syntax region texHref matchgroup=Delimiter start='{' end='}' contained
        \ nextgroup=texMatcher

  syntax match texCmd '\\hyperref\>' nextgroup=texHyperref
  syntax match texCmd '\\autoref\>' nextgroup=texHyperref
  syntax region texHyperref matchgroup=Delimiter start='\[' end='\]' contained
        \ contains=@texClusterRef,texRegionRef
  syntax region texHyperref matchgroup=Delimiter start='{' end='}' contained
        \ contains=@texClusterRef,texRegionRef

  highlight link texUrl          Function
  highlight link texUrlVerb      texUrl
  highlight link texHref         texUrl
  highlight link texHyperref     texRegionRef
endfunction

" }}}1

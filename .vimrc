" TODO
" * get vimux support

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" enable breakindent patch
set breakindent

" loads LaTeX-Suite_aka_Vim-LaTeX plugin
call vam#ActivateAddons(["LaTeX-Suite_aka_Vim-LaTeX", "vimux"], {"force_loading_plugins_now": 1})

" vimux settings (requires vim-nox to run!)
let g:VimuxOrientation = "v"
let g:VimuxHeight = "20"

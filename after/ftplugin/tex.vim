"""" Customisations to TeX-9.

if exists('g:maplocalleader')
	let s:maplocalleader_saved = g:maplocalleader
endif

let g:maplocalleader = b:tex_nine_config.leader 

" TeX-9 "helpfully" changes some of this... so dump it all inside after
setlocal softtabstop =2
setlocal tabstop     =2
setlocal shiftwidth  =2

setlocal wrap
setlocal linebreak
setlocal nolist
setlocal autoindent
setlocal fo+=t
setlocal fo+=l
setlocal fo-=n               " TeX can handle its own numbered lists...
setlocal fo+=w
setlocal tw=80

" ... and this
nnoremap <buffer> <F1> <nop>
nnoremap <buffer> <F2> <nop>
nnoremap <buffer> <F3> <nop>
nnoremap <buffer> <F4> :GundoToggle<CR><CR>

" for LaTeX quotes
" from auctex: https://github.com/vim-scripts/auctex.vim
function! s:TexQuotes()
	let insert = "''"
	let left = getline('.')[col('.')-2]
	if left =~ '^\(\|\s\)$'
		let insert = '``'
	elseif left == '\'
		let insert = '"'
	endif
	return insert
endfunction
inoremap <buffer> " <C-R>=<SID>TexQuotes()<CR>

" I like \varepsilon better
" XXX see why this required at all...
inoremap <buffer> <LocalLeader>e \varepsilon

" for angle brackets
inoremap <buffer> <LocalLeader>« \langle
inoremap <buffer> <LocalLeader>» \rangle

" Tap <LocalLeader>} to get {}. Very useful for custom commands!
" Similar maps for () and [] follow.
inoremap <buffer> <LocalLeader>} {}<Left>
inoremap <buffer> <LocalLeader>] []<Left>
inoremap <buffer> <LocalLeader>) ()<Left>

if exists('s:maplocalleader_saved')
	let g:maplocalleader = s:maplocalleader_saved
else
	unlet g:maplocalleader
endif

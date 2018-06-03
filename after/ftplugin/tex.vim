"""" Customisations to TeX-9.

if exists('g:maplocalleader')
	let s:maplocalleader_saved = g:maplocalleader
endif

let g:maplocalleader = b:tex_nine_config.leader 

" No need for this...
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
" And the same goes for \varphi
" XXX see why this required at all...
inoremap <buffer> <LocalLeader>e \varepsilon
inoremap <buffer> <LocalLeader>f \varphi
" and \emptyset is fugly...
inoremap <buffer> <LocalLeader>0 \varnothing
" and \hat is not very useful...
inoremap <buffer> <LocalLeader>^ \widehat{}<Left>

" for angle brackets
inoremap <buffer> <LocalLeader>« \langle
inoremap <buffer> <LocalLeader>» \rangle

if exists('s:maplocalleader_saved')
	let g:maplocalleader = s:maplocalleader_saved
else
	unlet g:maplocalleader
endif

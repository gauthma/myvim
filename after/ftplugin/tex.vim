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

" For LaTeX quotes, remap the default from .vimrc
inoremap :" ``''<Left><Left>

" I like \varepsilon better
" And the same goes for \varphi
" XXX see why this required at all...
inoremap <buffer> <LocalLeader>e \varepsilon
inoremap <buffer> <LocalLeader>f \varphi
" and \emptyset is fugly...
inoremap <buffer> <LocalLeader>0 \varnothing
" and \hat and \bar are not very useful...
inoremap <buffer> <LocalLeader>^ \widehat{}<Left>
inoremap <buffer> <LocalLeader>_ \overline{}<Left>
" and I use \cap and \cup far more than their \big versions...
inoremap <buffer> <LocalLeader>- \cap
inoremap <buffer> <LocalLeader>+ \cup
inoremap <buffer> <LocalLeader>-- \bigcap
inoremap <buffer> <LocalLeader>++ \bigcup
" also add shortcuts for big versions of \vee and \wedge
inoremap <buffer> <LocalLeader>vv \bigvee
inoremap <buffer> <LocalLeader>&& \bigwedge

" for angle brackets
inoremap <buffer> <LocalLeader>« \langle
inoremap <buffer> <LocalLeader>» \rangle

if exists('s:maplocalleader_saved')
	let g:maplocalleader = s:maplocalleader_saved
else
	unlet g:maplocalleader
endif

"""" Customisations to TeX-9.

if exists('g:maplocalleader')
	let s:maplocalleader_saved = g:maplocalleader
endif

let g:maplocalleader = b:tex_nine_config.leader 

let s:okularpartrc = "~/.config/okularpartrc"

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
" and \hat and \tilde and \bar are not very useful...
inoremap <buffer> <LocalLeader>^ \widehat{}<Left>
inoremap <buffer> <LocalLeader>~ \widetilde{}<Left>
inoremap <buffer> <LocalLeader>_ \overline{}<Left>
" the dotted variables for derivatives are so démodé
inoremap <buffer> <LocalLeader>. \cdot<Space>
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

" The reason to use this use this function, instead of TeX9's capability to
" open the pdf corresponding to a .tex file, is to be able, prior to invoking
" okular, to amend its editor= line to contain the current v:servername (which
" is unique per vim instance) used by vim. This allows to have backwards
" SyncTeX working, *on multiple* .tex file/okular viewer pairs.
"
function! s:OpenPDF(fpath)
	if filereadable(a:fpath)
		call system("sed -i 's/--servername .* --remote/--servername " . v:servername . " --remote/' " . expand(s:okularpartrc))
		call system("okular " . a:fpath . "&> /dev/null &")
		redraw!
	else
		echohl WarningMsg | echom("PDF not found (or not readable)! (" . a:fpath .")") | echohl None
	endif
endfunction
nnoremap <buffer> <LocalLeader>V :call <SID>OpenPDF(expand("%:p:r") . ".pdf")<CR>

" The downside of having backwards SyncTeX working on multiple instances of
" okular, is that we can no longer use an --unique instance. The lesser evil
" alternative is to kill the running version of okular, and create a new one,
" with the pdf positioned in the right page. Which is what this function does.
"
function! SyncTexForward()
  " Discover the pid of the running instance of okular. We start by grep'ing
  " the output of "ps aux" for "[o]kular". The square brackets ensure that the
  " grep process itself is excluded from the resulting list. We then grep that
  " result for the full name of the .tex file being edited. The "-F" tells
  " grep we are matching a literal string, which avoid having to escape
  " special characters, if there are any. Two grep instances are required
  " because the square brackets trick does not work in literal mode.
	let l:okular_pid = system("ps aux | grep \"[o]kular\" | grep -F '" . tex_nine#GetOutputFile() . "' | tr -s ' ' | cut -d' ' -f2") " TODO handle case of more than 1 (or none) pid returned

  " Kill okular instance containing pdf of .tex file being edited.
	call system("kill -TERM " . l:okular_pid)

  " Reset the servername in okular's config to the one used in the current
  " instance of (g)vim.
  call system("sed -i 's/--servername .* --remote/--servername " . v:servername . " --remote/' " . expand(s:okularpartrc))

	" TODO for a rainy day: figure out why the below line -- which needs no
	" redraw -- does NOT WORK: pdf just stays in the same place...
	" call system("okular --unique ".tex_nine#GetOutputFile()."\\#src:".line(".")."%:p &> /dev/null &")
	let cmd = "silent !okular ".tex_nine#GetOutputFile()."\\#src:".line(".")."%:p &> /dev/null &"
	exec cmd
	redraw!
	redrawstatus!
endfunction
nmap <Leader>f :call SyncTexForward()<CR>

if exists('s:maplocalleader_saved')
	let g:maplocalleader = s:maplocalleader_saved
else
	unlet g:maplocalleader
endif

" auto-wrap active by default
let s:auto_line_wrap_disabled = 0
let g:pandoc#syntax#conceal#use = 0

nnoremap <Leader>aw :call Toggle_auto_line_wrap()<CR>

" remember, visual select and gq to format manually!
setlocal wrap
setlocal linebreak
setlocal nolist
setlocal autoindent
setlocal tw=72
setlocal fo+=t
setlocal fo+=l
" --> fo=n makes vim treat lines that start with <number><space> as bullets...
setlocal fo-=n
" --> in pandoc (and Markdown) 2 trailing whitespaces mean <br/>
setlocal fo-=w

" avoid text right next to edge...
setlocal foldcolumn=1

" Asterisk is for bullet lists!
setlocal comments=fb:*

fun! Toggle_auto_line_wrap()
	if (s:auto_line_wrap_disabled == 0)
		let s:auto_line_wrap_disabled = 1
		autocmd! InsertEnter * 
		autocmd! InsertLeave * 
		set formatoptions-=a
		echo "Auto line-wrapping DISABLED!"
	elseif (s:auto_line_wrap_disabled == 1)
		let s:auto_line_wrap_disabled = 0
		autocmd InsertEnter * set formatoptions+=a 
		autocmd InsertLeave * set formatoptions-=a
		echo "Auto line-wrapping ACTIVE!"
	endif
endfun

" custom TeX text object for MathJax
vnoremap im vmq?\$<cr>lv/\$<cr>h
onoremap im :normal vim<CR>`q

" files with these two extensions are edited with kramdown (for octopress), "
" for which math code must ALWAYS be enclosed in $$ <...> $$. " Thus I
" modified the outer math motion to catch both $$, at " the beginning and the
" end.
autocmd BufEnter,BufNew *.markdown vnoremap am vmq?\$<cr>hvll/\$<cr>l
autocmd BufEnter,BufNew *.md       vnoremap am vmq?\$<cr>hvll/\$<cr>l

autocmd BufEnter,BufNew *.cmk vnoremap am vmq?\$<cr>v/\$<cr>
autocmd BufEnter,BufNew *.page vnoremap am vmq?\$<cr>v/\$<cr>

onoremap am :normal vam<CR>`q

" BEGIN gitit
" To allow gitit *.page files to be edited in vim
autocmd BufWritePost */wikidata/*.page call GitCommitOnWrite()

function! GitCommitOnWrite()
	let l:folder = expand('%:p:h')
	let l:file = expand('%:t')
	call system("cd " . shellescape(l:folder) . " ; git commit -m\"automated commit on save\" " . shellescape(l:file))
endfunction
" END gitit stuff

" TeX-9 magic
let g:maplocalleader = ":"
inoremap <buffer> <LocalLeader><LocalLeader> <LocalLeader>

" Greek
inoremap <buffer> <LocalLeader>a \alpha
inoremap <buffer> <LocalLeader>b \beta
inoremap <buffer> <LocalLeader>c \chi
inoremap <buffer> <LocalLeader>d \delta
inoremap <buffer> <LocalLeader>e \varepsilon
inoremap <buffer> <LocalLeader>f \varphi
inoremap <buffer> <LocalLeader>g \gamma
inoremap <buffer> <LocalLeader>h \eta
inoremap <buffer> <LocalLeader>k \kappa
inoremap <buffer> <LocalLeader>l \lambda
inoremap <buffer> <LocalLeader>m \mu
inoremap <buffer> <LocalLeader>n \nu
inoremap <buffer> <LocalLeader>o \omega
inoremap <buffer> <LocalLeader>p \pi
inoremap <buffer> <LocalLeader>q \theta
inoremap <buffer> <LocalLeader>r \rho
inoremap <buffer> <LocalLeader>s \sigma
inoremap <buffer> <LocalLeader>t \tau
inoremap <buffer> <LocalLeader>u \upsilon
inoremap <buffer> <LocalLeader>w \varpi
inoremap <buffer> <LocalLeader>x \xi
inoremap <buffer> <LocalLeader>y \psi
inoremap <buffer> <LocalLeader>z \zeta
inoremap <buffer> <LocalLeader>D \Delta
inoremap <buffer> <LocalLeader>F \Phi
inoremap <buffer> <LocalLeader>G \Gamma
inoremap <buffer> <LocalLeader>L \Lambda
inoremap <buffer> <LocalLeader>O \Omega
inoremap <buffer> <LocalLeader>P \Pi
inoremap <buffer> <LocalLeader>Q \Theta
inoremap <buffer> <LocalLeader>U \Upsilon
inoremap <buffer> <LocalLeader>X \Xi
inoremap <buffer> <LocalLeader>Y \Psi

" Math
inoremap <buffer> <LocalLeader>½ \sqrt{}<Left>
inoremap <buffer> <LocalLeader>N \nabla
inoremap <buffer> <LocalLeader>S \sum_{}^{}<Esc>F}i
inoremap <buffer> <LocalLeader>I \int\limits_{}^{}<Esc>F}i
inoremap <buffer> <LocalLeader>0 \emptyset
inoremap <buffer> <LocalLeader>6 \partial
inoremap <buffer> <LocalLeader>i \infty
inoremap <buffer> <LocalLeader>/ \frac{}{}<Esc>F}i
inoremap <buffer> <LocalLeader>v \vee
inoremap <buffer> <LocalLeader>& \wedge
inoremap <buffer> <LocalLeader>@ \circ
inoremap <buffer> <LocalLeader>\ \setminus
inoremap <buffer> <LocalLeader>= \equiv
inoremap <buffer> <LocalLeader>- \bigcap
inoremap <buffer> <LocalLeader>+ \bigcup
inoremap <buffer> <LocalLeader>< \leq
inoremap <buffer> <LocalLeader>> \geq
inoremap <buffer> <LocalLeader>~ \tilde{}<Left>
inoremap <buffer> <LocalLeader>^ \hat{}<Left>
inoremap <buffer> <LocalLeader>_ \bar{}<Left>
inoremap <buffer> <LocalLeader>. \dot{}<Left>

" Enlarged delimiters
inoremap <buffer> <LocalLeader>( \left(\right)<Esc>F(a
inoremap <buffer> <LocalLeader>[ \left[\right]<Esc>F[a
inoremap <buffer> <LocalLeader>{ \left\{ \right\}<Esc>F a

inoremap <buffer> ^^ ^{}<Esc>i
inoremap <buffer> __ _{}<Esc>i
inoremap <buffer> == &=

" for angle brackets
inoremap <buffer> <LocalLeader>« \langle
inoremap <buffer> <LocalLeader>» \rangle

" Tap <LocalLeader>} to get {}. Very useful for custom commands! (in LaTeX...)
" Similar maps for (), [] and $$ follow.
inoremap <buffer> <LocalLeader>} {}<Left>
inoremap <buffer> <LocalLeader>] []<Left>
inoremap <buffer> <LocalLeader>) ()<Left>
inoremap <buffer> <LocalLeader>$ $$<Left>

function! s:BuildOnWrite() " TODO language en pt...
	let l:filename = expand("%:p:t")
	let l:filepath = expand("%:p:h")

	" prevent gitit pages from being made into pdf...
	if l:filename =~ 'page$' | return | endif

	execute 'lcd' fnameescape(l:filepath)
	call system("pandoc -Ss -r markdown -V colorlinks ". l:filename ." -o ". l:filename .".pdf --latex-engine=xelatex &")
	lcd -
endfunction

function! s:OpenPDF(fpath)
	if !empty(glob(a:fpath))
		call system("okular " . a:fpath . "&> /dev/null &")
		redraw!
	else
		echohl WarningMsg | echom("PDF does not exist! (" . a:fpath .")") | echohl None
	endif
endfunction

nnoremap <LocalLeader>V :call <SID>OpenPDF(expand("%:p") . ".pdf")<CR>
command! WaB write | call s:BuildOnWrite()
cnoremap ww WaB

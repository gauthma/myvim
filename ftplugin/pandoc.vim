" auto-wrap active by default
let s:auto_line_wrap_disabled = 0
let g:pandoc#syntax#conceal#use = 0

nnoremap <Leader>aw :call Toggle_auto_line_wrap()<CR>

" remember, visual select and gq to format manually!
set wrap
set linebreak
set nolist
set autoindent
set tw=72
set fo+=t
set fo+=l
" --> fo=n makes vim treat lines that start with <number><space> as bullets...
set fo-=n
" --> in pandoc (and Markdown) 2 trailing whitespaces mean <br/>
set fo-=w

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

" files with these two extensions are edited with kramdown, 
" for which math code must ALWAYS be enclosed in $$ <...> $$.
" Thus I modified the outer math motion to catch both $$, at
" the beginning and the end.
autocmd BufEnter,BufNew *.markdown vnoremap am vmq?\$<cr>hvll/\$<cr>l
autocmd BufEnter,BufNew *.md       vnoremap am vmq?\$<cr>hvll/\$<cr>l

autocmd BufEnter,BufNew *.pandoc vnoremap am vmq?\$<cr>v/\$<cr>
autocmd BufEnter,BufNew *.pdc    vnoremap am vmq?\$<cr>v/\$<cr>

onoremap am :normal vam<CR>`q

" TeX-9 magic
let g:maplocalleader = ":"
inoremap <buffer> <LocalLeader><LocalLeader> <LocalLeader>

" Greek
inoremap <buffer> <LocalLeader>a \alpha
inoremap <buffer> <LocalLeader>b \beta
inoremap <buffer> <LocalLeader>c \chi
inoremap <buffer> <LocalLeader>d \delta
inoremap <buffer> <LocalLeader>e \varepsilon
inoremap <buffer> <LocalLeader>f \phi
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

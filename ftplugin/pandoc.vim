" avoid text right next to edge...
setlocal foldcolumn=1

" Asterisk is for bullet lists!
setlocal comments=fb:*

" custom TeX text object for MathJax
vnoremap im vmq?\$<cr>lv/\$<cr>h
onoremap im :normal vim<CR>`q

vnoremap am vmq?\$<cr>v/\$<cr>
onoremap am :normal vam<CR>`q

" In this case, there is no building to PDF...
autocmd BufEnter,BufNew *.markdown cnoremap ww w
autocmd BufEnter,BufNew *.md       cnoremap ww w

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
inoremap <buffer> <LocalLeader>0 \varnothing
inoremap <buffer> <LocalLeader>6 \partial
inoremap <buffer> <LocalLeader>i \infty
inoremap <buffer> <LocalLeader>/ \frac{}{}<Esc>F}i
inoremap <buffer> <LocalLeader>v \vee
inoremap <buffer> <LocalLeader>& \wedge
inoremap <buffer> <LocalLeader>vv \bigvee
inoremap <buffer> <LocalLeader>&& \bigwedge
inoremap <buffer> <LocalLeader>@ \circ
inoremap <buffer> <LocalLeader>\ \setminus
inoremap <buffer> <LocalLeader>= \equiv
inoremap <buffer> <LocalLeader>- \cap
inoremap <buffer> <LocalLeader>+ \cup
inoremap <buffer> <LocalLeader>-- \bigcap
inoremap <buffer> <LocalLeader>++ \bigcup
inoremap <buffer> <LocalLeader>< \leq
inoremap <buffer> <LocalLeader>> \geq
inoremap <buffer> <LocalLeader>~ \tilde{}<Left>
inoremap <buffer> <LocalLeader>^ \widehat{}<Left>
inoremap <buffer> <LocalLeader>_ \overline{}<Left>
inoremap <buffer> <LocalLeader>. \dot{}<Left>

" Big delimiters.
inoremap <buffer> <LocalLeader>( \left(\right)<Esc>F(a
inoremap <buffer> <LocalLeader>[ \left[\right]<Esc>F[a
inoremap <buffer> <LocalLeader>{ \left\{ \right\}<Esc>F a

" Most useful maps ever!
inoremap <buffer> ^^ ^{}<Esc>i
inoremap <buffer> __ _{}<Esc>i
inoremap <buffer> == &=

" For angle brackets.
inoremap <buffer> <LocalLeader>« \langle
inoremap <buffer> <LocalLeader>» \rangle

" Pandoc's common mark to PDF. Without arguments, just runs command in
" background (i.e. fire and forget). If called with argument "debug", runs in
" foreground (i.e. vim blocks until command finishes), and then prints the
" output, if there is any (in which case it is likely an error).
function! s:BuildOnWrite(...) " TODO language en pt...
	" Check if we are in debug mode or not.
	if a:0 > 0 && a:1 == 'debug'
		let l:debug = 1
	else
		let l:debug = 0
	end

	" Get current file's name and path.
	let l:filename = expand("%:p:t")
	let l:filepath = expand("%:p:h")

	" Set up pandoc command.
	let l:cmd = "pandoc -Ss -r markdown+autolink_bare_uris --toc -V colorlinks -V lang=UKenglish "
				\ . l:filename ." -o ". l:filename .".pdf --latex-engine=xelatex --highlight-style=zenburn 2>&1"
	" XXX change the language to portuguese, if required
	" If NOT in debug mode, command runs in the background.
	if l:debug == 0
		let l:cmd = l:cmd . " &"
	end

	" Change into file's directory, execute command, change back to previous
	" dir, print output if in debug mode (and if there is any output, which is
	" very likely the effect of error), and we are done.
	execute 'lcd' fnameescape(l:filepath)
	let l:output = system(l:cmd)
	lcd -
	if l:debug && len(l:output) > 0
		echoerr l:output
	end
endfunction
command! WaB write | call s:BuildOnWrite()
command! WaBd write | call s:BuildOnWrite("debug")
cnoremap ww WaB
cnoremap wd WaBd

function! s:OpenPDF(fpath)
	if filereadable(a:fpath)
		call system("okular " . a:fpath . "&> /dev/null &")
		redraw!
	else
		echohl WarningMsg | echom("PDF not found (or not readable)! (" . a:fpath .")") | echohl None
	endif
endfunction
nnoremap <LocalLeader>V :call <SID>OpenPDF(expand("%:p") . ".pdf")<CR>

" In MathJax, equation numbers have to be attributed manually, which means
" that if new equations are inserted in the middle of the text, the numbering,
" which should be sequential, will be "off by one" from that point onwards.
" This function corrects that, by finding all \tag{<number>} from that point
" onwards, and increasing the number by one.
" The first (last) thing the function does it to store the current location
" (return to the original location).
function! UpdateMathJaxTagsNumbers()
  normal mm
  let pattern = '\\tag{\(\d\+\)}'

  " The 'W' options is to prevent wrapping the search back to start of file.
  while search(pattern, 'W') 
    " Find the "tag" word, forward to the {, and move one char to the right.
    " That leaves the cursor on the number. Then increase it by one.
    normal! /tag
    normal! f{l
    normal! 
  endwhile
  normal `m
endfunction
command! Utags write | call UpdateMathJaxTagsNumbers()

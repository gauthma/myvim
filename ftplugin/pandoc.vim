" auto-wrap active by default
let s:auto_line_wrap_disabled = 0
let g:pandoc_syntax_dont_use_conceal_for_rules = [ "dashes", "list" ]

nnoremap <Leader>aw :call Toggle_auto_line_wrap()<CR>

set tw=68
set wrap
set fo+=t
set fo+=l
set fo+=n
set fo-=w "paragraph does NOT end at line which ends with non space ( setting this to +w borks gq} )

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

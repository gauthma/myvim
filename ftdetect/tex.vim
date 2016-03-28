au! Bufread,BufNewFile *.tex    set filetype=tex

" settings for Tex-9. Add the below line to the config
" to enable debug output.
" \'debug' : 1,
let g:tex_nine_config = {
			\'leader': ':',
			\'compiler': 'make',
			\'viewer': {'app':'okular', 'target':'pdf'},
		\}


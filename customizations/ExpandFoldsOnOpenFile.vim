autocmd BufWinEnter <buffer> :call ExpandFoldsOnOpenFile()

function! ExpandFoldsOnOpenFile()
	if exists("b:did_initial_fold_expansion") | return
	endif
	let b:did_initial_fold_expansion = 1
	normal zR
endfunction

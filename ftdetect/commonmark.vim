" Pandoc (extension .cmk, for commonmark)
au! Bufread,BufNewFile *.cmk          set filetype=pandoc
au! Bufread,BufNewFile *.md           set filetype=pandoc
au! Bufread,BufNewFile *.markdown     set filetype=pandoc

" for gitit data files
au! Bufread,BufNewFile */wikidata/*.page     set filetype=pandoc

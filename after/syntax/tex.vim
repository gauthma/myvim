""""" SYNTAX RULES FOR ÜBER COMPLICATED FILES
"" For large .tex files, vim's syntax rules can become confused and, among
"" things, this might screw up spell checking. To avoid this, you can either
"" syntax to proceed from the start of the file.
"
" syntax sync fromstart
"
"" But this has the disadvantage of becoming slow. To overcome this, force vim
"" to look backwards, until it finds the start of a \section, and let syntax
"" parsing begin from there. I think that is is very rare for a section to have
"" more than 500 lines, set that a limit! (the default is too small)

syntax sync minlines=500 match LaTeXSection       grouphere texSectionZone       "^\s*\\section{[a-zA-Z0-9]\+"

"" For further details see:
"" see https://stackoverflow.com/questions/23353009/vim-spellcheck-not-always-working-in-tex-file-check-region-in-vim

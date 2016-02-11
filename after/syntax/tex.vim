" see https://stackoverflow.com/questions/23353009/vim-spellcheck-not-always-working-in-tex-file-check-region-in-vim
syntax sync fromstart

" see https://stackoverflow.com/questions/6738902/vim-syntax-highlighting-with-and-lstlistings-lstinline
syn region texZone start="\\begin{minted}" end="\\end{minted}\|%stopzone\>"

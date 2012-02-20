" IMPORTANT NOTICE: when using this config(*) in a new computer, 
" the first thing to do is to clone vundle:
" git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git
"
" Next, enter vim, and in normal mode, do :BundleInstall
" This will clone all the required plugins from their repos (github, et al.)
"
" More info here: http://www.charlietanksley.net/philtex/sane-vim-plugin-management/
" 
" (*) The config I use can be found here: https://github.com/gauthma/myvim

set nocompatible    " use vim defaults
let mapleader = ","

" to use vundle
filetype off  " required!

set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

filetype plugin indent on  " required!

"hidden
set hidden

" disable cursorline in netrw (scp et al. over vim)
let g:netrw_cursorline = 0 

""" tab stuff
"set expandtab
set softtabstop=2
set tabstop=2       " numbers of spaces of tab character
set shiftwidth=2    " numbers of spaces to (auto)indent
set smarttab

" indentation, scrolling, et al.
set scrolloff=3     " keep 3 lines when scrolling
set autoindent      " always set autoindenting on
"set smartindent --> DO NOT ENABLE! starts indenting C keywords in ANY file...
"set cindent         " cindent
set showcmd         " display incomplete commands
set ruler           " show the cursor position all the time
set nonumber          " show line numbers
set title           " show title in console title bar
set ttyfast         " smoother changes
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set nojoinspaces    " when joining lines, never put two spaces after .,?! et al

""" search options
set ignorecase      " ignore case when searching
set hlsearch        " highlight searches
set incsearch       " do incremental searching

""" set fold options
set foldmethod=indent
set foldignore=""
autocmd BufWinEnter * norm zR

" more settings
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" give this a try
set nobackup
"set noswapfile

" toggle set paste
nmap <Leader>p :set paste<CR>"+P:set nopaste<CR>

" gui font
set gfn=Monospace\ 10

if version>=600
   syntax on " syntax highlighing

   " Filetypes (au = autocmd)
   au filetype help set nonumber      " no line numbers when viewing help
   au filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
   au filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back

   " File formats
   au BufNewFile,BufRead  *.pls    set syntax=dosini
   au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
   "au BufNewFile,BufRead  *.py    set syntax=python
endif

"for current date
iab ddate <C-R>=strftime("%A, %d of %B of %Y")<CR>
iab ttime <C-R>=strftime("%H:%M")<CR>

"for sagemath syntax
augroup filetypedetect
       au! BufRead,BufNewFile *.sage,*.spyx,*.pyx setfiletype python
augroup END

" save fold status automagically
set viewoptions=folds " save only folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

"tex file highlight 80
au BufEnter *.tex call WriteLaTeXMode()
au WinEnter *.tex call WriteLaTeXMode()

function WriteTextMode()
	" remember, visual select and gq to format manually!
	set wrap
	"set linebreak
	set fo+=t
	set fo+=a 
	set fo+=n
	"--> in pandoc (and Markdown) 2 trailing whitespaces mean <br/>
	"set fo+=w "trailing whitespace does NOT indicate end of paragraph
	set tw=80
endfunction

function WriteLaTeXMode()
	"set wrap
	"set linebreak
	set fo+=t
	set fo+=l
	set fo+=n
	set fo+=w
	set tw=80
endfunction

if &diff
	set t_Co=256
	set background=dark
	colorscheme peaksea
else
	colorscheme my_evening
endif

"for shell in bash (Shell.vim in .vim/ftplugin)
source ~/.vim/ftplugin/Shell.vim
runtime! ftplugin/man.vim

"for NERDTree
map <F2> :NERDTreeToggle<CR>

" iQuickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" and other files
nmap <silent> <leader>essh :e ~/.ssh/config<CR>

" AHAHAHAAH :-D
" Use the damn hjkl keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap j gj
nnoremap k gk

" clear search highlights
nmap <silent> ,/ :let @/=""<CR>

" open tag in new tab
nmap <S-T> <C-w><C-]>

" switch header and src file -- C++
nmap <S-F2> :A<CR>

" sudo to the rescue! Do :ww and you write in sudo mode! 
command! -bar -nargs=0 W2 :silent exe "write !sudo tee % >/dev/null" | silent edit!
cmap ww W2

" brings up command prompt in vim
nmap <Leader>cc :! 

" brings up cmd prompt, filled with the last executed command
" (just pressing <CR> will run it)
nmap <Leader>cp :! <up>

" toggle foldmethod between indent and marker
map <leader>tf :call ToggleFold()<cr>
fun! ToggleFold()
	if &foldmethod == 'marker'
		exe 'set foldmethod=indent'
		echo "Fold method set to INDENT"
	else
		exe 'set foldmethod=marker'
		echo "Fold method set to MARKER"
	endif
endfun

" select a couple of lines, and this will wrap them in {{{ }}} and collapse the fold.
" useful for hiding large portions of source code, for instance
vmap <Leader>H mz:<Esc>:set paste<CR>'<O {{{<Esc><C-c>'>o }}}<Esc><C-c>`z?{{{<CR>A<Space><Esc>:set nopaste<CR>:set foldmethod=marker<CR><Esc>zc

" In LaTeX et al., a paragraph is usually separated by a blank line before, and
" a blank line after. This command justifies that text (auto-wrapping *modified* text
" is disabled)
nmap <Leader>j <Esc>{gqgqj<S-V>}kJgqgq

" for mail spell checking (et al.)
nmap <M-F5> <Esc>:set spell<CR>
imap <M-F5> <Esc>:set spell<CR>
nmap <M-F6> <Esc>:set nospell<CR>
imap <M-F6> <Esc>:set nospell<CR>

set spelllang=en "XXX way to toggle this with pt?
set spellfile=~/.vim/spell.en.utf-8.add

" for mutt mail composing
au BufNewFile,BufRead /tmp/mutt*  setf mail
au BufNewFile,BufRead /tmp/mutt*  set ai et tw=68 

"for status line
set laststatus=2

" VUNDLE plugin list
" repos at github vim-script mirror of vim.org
Bundle 'comment.vim'
Bundle 'comments.vim'
Bundle 'The-NERD-tree'
Bundle 'netrw.vim'
Bundle 'superSnipMate'
Bundle 'surround.vim'
Bundle 'a.vim'
Bundle 'DoxygenToolkit.vim'
Bundle 'allfold'

Bundle 'https://github.com/Raimondi/delimitMate.git'
Bundle 'https://github.com/mikewest/vimroom.git'

Bundle 'mileszs/ack.vim'

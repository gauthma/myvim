set nocompatible    " use vim defaults

" Use pathogen to easily modify the runtime path to include all
" " plugins under the ~/.vim/bundle directory
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on

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

""" search options
set ignorecase      " ignore case when searching
set hlsearch        " highlight searches
set incsearch       " do incremental searching

""" set fold options
set foldmethod=indent
set foldignore=""
autocmd BufWinEnter * norm zR

" more tralha
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" give this a try
set nobackup
set noswapfile

" toggle set paste
set pastetoggle=<F3>

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

" for omnicompletion...
filetype plugin indent on
syntax enable

"for current date
iab ddate <C-R>=strftime("%A, %d of %B of %Y")<CR>
iab ttime <C-R>=strftime("%H:%M")<CR>

"for sagemath syntax
augroup filetypedetect
       au! BufRead,BufNewFile *.sage,*.spyx,*.pyx setfiletype python
augroup END

"for 80 char line limit
"au BufReadPre * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"au BufReadPre * match OverLength /\%81v.*/

"tex file highlight 80
au BufEnter *.tex call WriteLaTeXMode()
au WinEnter *.tex call WriteLaTeXMode()

"wrap 80 char lines
au BufEnter *.pdc call WriteTextMode()
au WinEnter *.pdc call WriteTextMode()

function WriteTextMode()
	" remember, select and gq to format manually!
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

"for CMAKE
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim 
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

colorscheme my_evening

"for shell in bash (Shell.vim in .vim/ftplugin)
source ~/.vim/ftplugin/Shell.vim
runtime! ftplugin/man.vim

"for NERDTree
map <F2> :NERDTreeToggle<CR>

"parenthesis et al. autoclosing (XXX beware Lisp, LaTeX...)
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
"inoremap { {<CR>}<Esc>O
inoremap {<CR> {<CR>}<Esc>ko
"autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
"inoremap ' <c-r>=QuoteDelim("'")<CR>
"inoremap } <c-r>=ClosePair('}')<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function CloseBracket()
	if match(getline('.'), '.*{.*\({.*}\)*[^}]*$') >= 0
		return "}"
	elseif match(getline(line('.') + 1), '\s*}') < 0
		return "\<CR>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf
"END parenthesis stuff

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

" sudo to the rescue!
cmap w!! w !sudo tee % >/dev/null

" brings up command prompt in vim
nmap ,cc :! 

" brings up cmd prompt, filled with the last executed command
" (just pressing <CR> will run it)
nmap ,cp :! <up>

" for now, just english...
map <M-F5> :set spell<CR>
map <M-F6> :set nospell<CR>

" VIM LATEX *************
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
""filetype plugin on -> already done

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" END VIM LATEX *************

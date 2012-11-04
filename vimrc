set nocompatible    " use vim defaults
let g:mapleader = ","
let g:maplocalleader = ";"
let g:lisp_rainbow=1

" to use vundle
filetype off  " required!

set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

filetype plugin indent on  " required!

""" buffers
set hidden
nnoremap <F4> :buffers<CR>:buffer<Space>

nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

""" misc
" disable cursorline in netrw (scp et al. over vim)
let g:netrw_cursorline = 0 
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " show title in console title bar
set visualbell           " don't beep
set noerrorbells         " don't beep
set ttyfast              " smoother usage by assuming fast connection to terminal
set writebackup          " write backups when overwriting files
set nobackup             " but don't keep afer successful overwrite
syntax on                " syntax highlighing
au filetype help set nonumber                  " no line numbers when viewing help
au filetype help nnoremap <buffer><cr> <c-]>   " Enter selects help subject
au filetype help nnoremap <buffer><bs> <c-T>   " Backspace goes back

" File formats
au BufNewFile,BufRead  *.pls    set syntax=dosini
au BufNewFile,BufRead  modprobe.conf    set syntax=modconf

""" tab stuff
set noexpandtab
set softtabstop=2
set tabstop=2       " numbers of spaces of tab character
set shiftwidth=2    " numbers of spaces to (auto)indent
set smarttab        " use shiftwidth when inserting Tab in line start

" and about VIM tabs
set tabpagemax=200 " XXX this might be removed in the future

" indentation, scrolling, ponctuation et al.
set scrolloff=3     " keep 3 lines when scrolling
set autoindent      " always set autoindenting on
"set smartindent -->  DO NOT ENABLE! starts indenting C keywords in ANY file...
"set cindent        " cindent
set cinoptions=l1   " otherwise the case statement is wrongly indented (see :help cinoptions-values)
set showcmd         " display incomplete commands
set ruler           " show the cursor position all the time
set nonumber        " show line numbers (or not)
set shortmess=atI   " Abbreviate messages
set nostartofline   " try to leave cursor in same column when going up and down...
set nojoinspaces    " when joining lines, never put two spaces after .,?! et al
set foldmethod=marker

""" search 
set noignorecase    " DO NOT ignore case when searching -> best default
set hlsearch        " highlight searches
set incsearch       " do incremental searching

" toggle set paste
nmap <Leader>p :set paste<CR>"+P:set nopaste<CR>

" gui font (XXX remove this? I never use GUI these days...)
set gfn=Monospace\ 10

"for current date
iab ddate <C-R>=strftime("%A, %d of %B of %Y")<CR>
iab ttime <C-R>=strftime("%H:%M")<CR>

"tex file highlight 80
au BufEnter *.tex call WriteLaTeXMode()
au WinEnter *.tex call WriteLaTeXMode()
" and set the mode for pandoc 
au BufEnter *.pdc call WriteTextMode()
au WinEnter *.pdc call WriteTextMode()

" tell pandoc plugin NOT to fold sections (by default)
let g:pandoc_no_folding = 1

function WriteTextMode()
	" remember, visual select and gq to format manually!
	set wrap
	"set linebreak
	set fo+=t
	set fo-=a 
	set fo+=n
	"--> in pandoc (and Markdown) 2 trailing whitespaces mean <br/>
	set fo-=w "trailing whitespace does NOT indicate end of paragraph
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
elseif has("gui_running")
	colorscheme oceandeep
else
	colorscheme my_evening
endif

" toggle hex mode
noremap <Leader>h :%!xxd<CR>
noremap <Leader>nh :%!xxd -r<CR>

" iQuickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>

" and other files
nnoremap <silent> <leader>ssh :e ~/.ssh/config<CR>

" AHAHAHAAH :-D
" Use the damn hjkl keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

nnoremap j gj
nnoremap k gk

" clear search highlights
nnoremap <silent> ,/ :let @/=""<CR>

" sudo to the rescue! Do :ww and you write in sudo mode! 
command! -bar -nargs=0 W2 :silent exe "write !sudo tee % >/dev/null" | silent edit!
cnoremap ww W2

" brings up command prompt in vim
nnoremap <Leader>cc :! 

" brings up cmd prompt, filled with the last executed command
" (just pressing <CR> will run it)
nnoremap <Leader>cp :! <up>

" auto-justify selected text
vnoremap <Leader>J Jgqgq

" and the automatic version for blank-line
" delimited paragraphs
nnoremap <Leader>j <Esc>{gqgqj<S-V>}kJgqgq

" for mail spell checking (et al.) -- someday this will be a function, that
" takes into account the filetype, and sets aspell accordingly
vnoremap <M-F5> :w! /tmp/aspell:'<,'>d:!aspell check -l en_GB /tmp/aspell<Esc>k:r /tmp/aspell
vnoremap <M-F6> :w! /tmp/aspell:'<,'>d:!aspell check -l pt_PT /tmp/aspell<Esc>k:r /tmp/aspell

" for mutt mail composing
au BufNewFile,BufRead /tmp/mutt*  setf mail
au BufNewFile,BufRead /tmp/mutt*  set ai et tw=68
au BufNewFile,BufRead /tmp/mutt*  startinsert

"for status line
set laststatus=2
set wildmenu

" Vertical Split Buffer Function
function VerticalSplitBuffer(buffer)
    execute "vert belowright sb" a:buffer 
endfunction

" Vertical Split Buffer Mapping - call like :Vb <buf-num>
command -nargs=1 Vb call VerticalSplitBuffer(<f-args>)

" NerdTree 
noremap <F2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
noremap <leader>e :NERDTreeFind<CR>
nnoremap <leader>nt :NERDTreeFind<CR>

"let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1

" settings for Tex-9
let g:tex_flavor="xetex"

" for gundo
nnoremap <F5> :GundoToggle<CR><CR>

" syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
			\ 'active_filetypes': [],
			\ 'passive_filetypes': [] }
noremap <F3> :SyntasticToggle<CR>
" Note: I map the toggle command because the messages from  SyntaxCheck
" command cannot be cleared (you have to close and re-open the file). Not so
" with SyntasticToggle 

" VUNDLE plugin list
" repos at github vim-script mirror of vim.org
Bundle 'comment.vim'
Bundle 'comments.vim'
Bundle 'The-NERD-tree'
Bundle 'netrw.vim'
Bundle 'superSnipMate'
Bundle 'surround.vim'
Bundle 'DoxygenToolkit.vim'
Bundle 'vim-pandoc'
Bundle 'slimv.vim'
Bundle 'TeX-9'

Bundle 'https://github.com/Raimondi/delimitMate.git'
Bundle 'https://github.com/mikewest/vimroom.git'
Bundle 'https://github.com/sjl/gundo.vim'
Bundle 'https://github.com/rson/vim-conque'
Bundle 'https://github.com/scrooloose/syntastic.git'
Bundle 'https://github.com/dhallman/bufexplorer.git'

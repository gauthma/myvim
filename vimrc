set nocompatible    " use vim defaults
let g:mapleader = ","
let g:maplocalleader = ";"
let g:lisp_rainbow=1

execute pathogen#infect()
filetype plugin indent on  " required!

" Themes
" this has to come after loading solarized colorscheme
if &diff
	set t_Co=256
	set background=dark
	colorscheme peaksea
elseif has("gui_running")
	" gui font (get it here: https://aur.archlinux.org/packages/ttf-inconsolata-g)
	set guifont=Inconsolata-g\ 12
	set background=dark
	colorscheme solarized
else
	set background=dark
	colorscheme solarized
endif

""" buffers
set hidden
nnoremap <Leader>d :bdelete<CR>

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
set softtabstop =2
set tabstop     =2      " numbers of spaces of tab character
set shiftwidth  =2      " numbers of spaces to (auto)indent
set smarttab            " use shiftwidth when inserting Tab in line start

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
nmap <Leader>ep :set paste<CR>"+P:set nopaste<CR>

"for current date
iab ddate <C-R>=strftime("%A, %d of %B of %Y")<CR>
iab ttime <C-R>=strftime("%H:%M")<CR>

" adapt as needed
iab <Leader>-- --Óscar

"tex file highlight 80
au BufEnter *.tex call WriteLaTeXMode()
au WinEnter *.tex call WriteLaTeXMode()
" and set the mode for pandoc
au BufEnter *.pdc call WriteTextMode()
au WinEnter *.pdc call WriteTextMode()

" tell pandoc plugin NOT to fold sections (by default)
let g:pandoc_no_folding = 1
let g:pandoc_use_hard_wraps = 1

function WriteTextMode()
	" remember, visual select and gq to format manually!
	set wrap
	"set linebreak
	set fo+=t
	set fo-=a
	set fo+=n
	"--> in pandoc (and Markdown) 2 trailing whitespaces mean <br/>
	set fo-=w "trailing whitespace does NOT indicate end of paragraph
	set tw=68
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

" toggle relative line numbers
nnoremap <Leader>m :set invrelativenumber<CR>
"nnoremap <C-M><C-M> :set invrelativenumber<CR>

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

" also, switching windows is easier like this
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-y> <c-w>r

" clear search highlights
nnoremap <silent> ,/ :let @/=""<CR>

" sudo to the rescue! Do :W2 and you write in sudo mode!
command! -bar -nargs=0 W2 :silent exe "write !sudo tee % >/dev/null" | silent edit!

" brings up command prompt in vim
nnoremap <Leader>cc :!

" brings up cmd prompt, filled with the last executed command
" (just pressing <CR> will run it)
nnoremap <Leader>cp :! <up>

" justify selected text
vnoremap <Leader>Q Jgqgq<Esc>:set nornu<CR>

" justify paragraph
nnoremap Q gq}

" for mutt mail composing
au BufNewFile,BufRead /tmp/mutt*  setf mail
au BufNewFile,BufRead /tmp/mutt*  set ai et tw=68
au BufNewFile,BufRead /tmp/mutt*  startinsert

"for status line (vim-air)
set laststatus=2
set wildmenu

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

" settings for Conque (terminal in vim split)
let g:ConqueTerm_EscKey = '<C-O>'
let g:ConqueTerm_InsertOnEnter = 1

" settings for Tex-9
let g:tex_nine_config = {
			\'compiler': 'make',
			\'viewer': {'app':'okular', 'target':'pdf'},
		\}

" for gundo
nnoremap <F4> :GundoToggle<CR><CR>

" vim-air
let g:airline#extensions#whitespace#checks = [ ]

nnoremap <silent> v v:<C-u>set nonu rnu<CR>gv
nnoremap <silent> V V:<C-u>set nonu rnu<CR>gv
nnoremap <silent> <C-v> <C-v>:<C-u>set nonu rnu<CR>gv

vnoremap <Esc> <Esc>:set nornu<CR>
"autocmd CursorMoved * if mode() !~# "[vV\<C-v>]" | set nornu | endif
"
"Adapted from here:
"https://stackoverflow.com/questions/13344987/how-can-i-activate-relative-line-numbering-in-and-only-in-vims-visual-mode
"
" I commented out the autocmd CursorMoved because makes moving the mouse 
" with the arrows too slow. It still works, as long as exits visual mode 
" using the <Esc> key... otherwise, there's always Ctrl-L...

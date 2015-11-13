set nocompatible    " use vim defaults
let g:mapleader=" " " as it happens, <Space> does not work...

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

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

""" misc
" disable cursorline in netrw (scp et al. over vim)
let g:netrw_cursorline = 0
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " show title in console title bar
set visualbell           " don't beep
set noerrorbells         " don't beep
set ttyfast              " smoother usage by assuming fast connection to terminal
set writebackup          " write backups when overwriting files
set nobackup             " but don't keep afer successful overwrite
syntax on                " syntax highlighing
autocmd filetype help set nonumber                  " no line numbers when viewing help
autocmd filetype help nnoremap <buffer><cr> <c-]>   " Enter selects help subject
autocmd filetype help nnoremap <buffer><bs> <c-T>   " Backspace goes back
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
set incsearch       " do incremental searching
set nohlsearch      " DO NOT highlight searches (but allow F5 to toggle -- see next line)
" toggle highlighting and incremental search
nnoremap <leader><leader>  :set invhlsearch<CR>:set incsearch<CR>

" toggle set paste
set pastetoggle=<F12>
" for easier copy/paste from the system clipboard
xnoremap <Leader>y "+y
nnoremap <Leader>p "+p
inoremap <C-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a

" toggle relative line numbers
nnoremap <Leader>r :set invrelativenumber<CR>

" toggle hex mode
noremap <Leader>h :%!xxd<CR>
noremap <Leader>nh :%!xxd -r<CR>

" iQuickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
" and other files
source ~/.vim/customizations/shortcuts_for_files.vim

nnoremap j gj
nnoremap k gk

" Manual solution for parenthesis et al. completion: 
" insert both, and then hit <left>, with a "closer" shortcut.
" The "right" shortcut is for when you want to continue past the delimiter.
inoremap <C-h> <left>
inoremap <C-l> <right>

" also, switching windows is easier like this
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-y> <c-w>r

" and make splitting more natural
set splitbelow
set splitright

" brings up command prompt in vim
nnoremap <Leader>cc :!

" brings up cmd prompt, filled with the last executed command
" (just pressing <CR> will run it)
nnoremap <Leader>cp :! <up>

" Spell check toggling
"" Switch Spellchecking English
nnoremap <Leader>sse :setlocal spell spelllang=en<CR>
"" Switch Spellchecking Portuguese
nnoremap <Leader>ssp :setlocal spell spelllang=pt<CR>
"" Switch Spellchecking None
nnoremap <Leader>ssn :setlocal nospell<CR>

" justify current paragraph
nnoremap <Leader>Q mqvipJgq}<Esc>:set nornu<CR>`q
" justify selection, and put cursor in the end of last selected line
vnoremap <Leader>Q Jgqgq<Esc>:set nornu<CR>`.$
" justify paragraph, from current line onwards
nnoremap Q mqgq}`q

" (files) to be ignored...
set wildignore+=*.o,*.a,*.bak,*.pyc,*.class
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" add ctrlp's ignore list...
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" disable "smart" working path directory...
let g:ctrlp_working_path_mode = '0'

" for status line (vim-air)
set laststatus=2
set wildmenu
set wildmode=list:longest
let g:airline_section_z = "%3p%% :%4l:%3v "

" NerdTree
noremap <F2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
noremap <Leader>f :NERDTreeFind<CR>

"let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1

" settings for Tex-9. Add the below line to the config
" to enable debug output.
" \'debug' : 1,
let g:tex_nine_config = {
			\'leader': ':',
			\'compiler': 'make',
			\'viewer': {'app':'okular', 'target':'pdf'},
		\}

" for gundo
nnoremap <F4> :GundoToggle<CR><CR>

" vim-air
let g:airline#extensions#whitespace#checks = [ ]

" narrow region
vmap <Leader>nn	<Leader>nr
nmap <F3> <Plug>NrrwrgnWinIncr

" tagbar side bar
nnoremap <silent> <F12> :TagbarToggle<CR>
" also, to be able to jump to tag definition
nnoremap <leader>. :CtrlPTag<cr>

" nnoremap <silent> v v:<C-u>set nonu rnu<CR>gv
" nnoremap <silent> V V:<C-u>set nonu rnu<CR>gv
" nnoremap <silent> <C-v> <C-v>:<C-u>set nonu rnu<CR>gv

" vnoremap <Esc> <Esc>:set nornu<CR>
"autocmd CursorMoved * if mode() !~# "[vV\<C-v>]" | set nornu | endif
"
"Adapted from here:
"https://stackoverflow.com/questions/13344987/how-can-i-activate-relative-line-numbering-in-and-only-in-vims-visual-mode
"
" I commented out the autocmd CursorMoved because makes moving the mouse 
" with the arrows too slow. It still works, as long as exits visual mode 
" using the <Esc> key... otherwise, there's always Ctrl-L...

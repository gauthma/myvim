syntax on              " syntax highlighing
set nocompatible       " use vim defaults
let g:mapleader=" "    " as it happens, <Space> does not work...
let &titleold=getcwd() " so long, \"thanks for flying vim\"...

execute pathogen#infect()
filetype plugin indent on  " required!
" Themes
" this has to come after loading solarized colorscheme
if &diff
	set t_Co=256
	set background=dark
	colorscheme solarized
elseif has("gui_running")
	" gui font (get it here: https://aur.archlinux.org/packages/ttf-inconsolata-g)
	set guifont=Inconsolata-g\ 13
	set background=dark
	colorscheme solarized
else
	set background=dark
	colorscheme solarized
endif

"
" Settings, lettings and autocmds
"

" for i3: when resizing, leave splits untouched
autocmd VimResized * wincmd =

" and make splitting more natural
set splitbelow
set splitright

let g:netrw_cursorline = 0 " disable cursorline in netrw (scp et al. over vim)

set history=1000           " remember more commands and search history
set undolevels=1000        " use many muchos levels of undo
set title                  " show title in console title bar
set visualbell             " don't beep
set noerrorbells           " don't beep
set ttyfast                " smoother usage by assuming fast connection to terminal
set writebackup            " write backups when overwriting files
set nobackup               " but don't keep afer successful overwrite

autocmd filetype help set nonumber                  " no line numbers when viewing help
autocmd filetype help nnoremap <buffer><cr> <c-]>   " Enter selects help subject
autocmd filetype help nnoremap <buffer><bs> <c-T>   " Backspace goes back
" File formats
au BufNewFile,BufRead  *.pls    set syntax=dosini
au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
" show soft broken lines
set showbreak=…

""" tab stuff
set expandtab           " if you can't win...
set softtabstop =2      " in insert/edit, it is the <Space>-length of <Tab>
set tabstop     =2      " numbers of spaces of tab character (in view mode)
set shiftwidth  =2      " numbers of spaces to (auto)indent (eg << and >>)
set smarttab            " use shiftwidth when inserting Tab in line start

" and about VIM tabs
set tabpagemax=200 " XXX this might be removed in the future

" indentation, scrolling, ponctuation et al.
set scrolloff=3     " keep 3 lines when scrolling
set autoindent      " always set autoindenting on
set showcmd         " display incomplete commands
set ruler           " show the cursor position all the time
set nonumber        " show line numbers (or rather don't not)
set shortmess=atI   " Abbreviate messages
set nostartofline   " try to leave cursor in same column when going up and down...
set nojoinspaces    " when joining lines, never put two spaces after .,?! et al
set foldmethod=marker

""" search
set noignorecase    " DO NOT ignore case when searching -> best default
set incsearch       " do incremental searching
set nohlsearch      " DO NOT highlight searches (but allow toggling -- see next line)
" toggle set paste
set pastetoggle=<F1>

" when typing in terminal vim, skip Esc delay (by pressing other keys)
inoremap <Esc> <Esc>:<C-c>

set hidden " don't unload (close?) buffers unless I tell you so!

" (files) to be ignored...
set wildignore+=*.o,*.a,*.bak,*.pyc,*.class
set wildignore+=/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

"
" Maps, of all shapes and sizes!
"

" toggle highlighting and incremental search
nnoremap <Leader><Leader>  :set invhlsearch<CR>:set incsearch<CR>

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
nnoremap <Leader>bd :bd<CR>

" also, resizing and switching buffers is easier like this
nnoremap <C-up>    <C-w>+
nnoremap <C-down>  <C-w>-
nnoremap <C-right> <C-w>>
nnoremap <C-left>  <C-w><
" Basically: up and right equal bigger, down and left equal smaller

" moving between splits, made easy
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" for switching the position of splits
nnoremap <S-Down>  <C-w><S-j>
nnoremap <S-Up>    <C-w><S-k>
nnoremap <S-Right> <C-w><S-l>
nnoremap <S-Left>  <C-w><S-h>
nnoremap <S-s>     <C-w>r
" NOTA BENE: <S-Up> and <S-Down> work in gvim, but may not in vim, depending on terminal

" for easier copy/paste from the system clipboard
xnoremap <Leader>y "+y
inoremap <C-v> <Esc>:set paste<CR>"+p<F1>a
" NB: you can still insert '^V' (for literal char codes); 
" just do it in PASTE "mode" (i.e. press <F1>!).

" toggle relative line numbers
nnoremap <Leader>r :set invrelativenumber<CR>

" toggle hex mode
noremap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
noremap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" In case there are long lines...
nnoremap j gj
nnoremap k gk

" Manual solution for parenthesis et al. completion: 
" insert both, and then hit <left>, with a "closer" shortcut.
" The "right" shortcut is for when you want to continue past the delimiter.
inoremap <C-h> <left>
inoremap <C-l> <right>

" Tap :} to get {}. Very useful for custom commands!
" Similar maps for (), [] and $$ follow.
inoremap :} {}<Left>
inoremap :] []<Left>
inoremap :) ()<Left>
inoremap :$ $$<Left>

" Same for quotes
inoremap :" ""<Left>
inoremap :' ''<Left>

" And tap :backspace to delete the pair of braces/quotes
" if you got the wrong one (very common in practice!)
inoremap :<BS> <Esc>2xi

" And of course, tap :: to actually get :
inoremap :: :
" NB: These mappins come from LaTeX/pandoc, but they seem useful in other
" places as well, so I "promoted" them to vimrc!

" brings up command prompt in vim
nnoremap <Leader>cc :! 

" brings up cmd prompt, filled with the last executed command
" (just pressing <CR> will run it)
nnoremap <Leader>cp :<up>

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

" iQuickly edit/reload the vimrc (and other files)
" (that file only contains map commands, so this line goes in this section).
source ~/.vim/customizations/shortcuts_for_files.vim

"
" Plugin setup
"

" experimental: make ctrlp begin in last used mode...
let g:ctrlp_cmd = 'CtrlPLastMode'
" add ctrlp's ignore list...
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" disable "smart" working path directory...
let g:ctrlp_working_path_mode = '0'

" for status line (vim-air)
set laststatus=2
set wildmenu
set wildmode=list:longest
let g:airline_section_z = "%3p%% :%4l:%3v "
let g:airline#extensions#whitespace#checks = [ ]

" for gundo
nnoremap <F4> :GundoToggle<CR><CR>

" narrow region
vmap <Leader>nn <Leader>nr<CR>
nmap <F3> <Plug>NrrwrgnWinIncr

" tagbar side bar
nnoremap <silent> <F12> :TagbarToggle<CR>
" also, to be able to jump to tag definition
nnoremap <leader>. :CtrlPTag<cr>

" DO NOT use conceal (appearently this only works if it is placed in vimrc)
let g:pandoc#syntax#conceal#use=0


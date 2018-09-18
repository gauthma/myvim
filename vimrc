syntax on                  " syntax highlighing

execute pathogen#infect()
filetype plugin indent on  " required!

"
" Themes / GUI
"
set background=light
colorscheme solarized
if &diff || !has('gui_running')
	set t_Co=256
elseif has("gui_running")
	" gui font (get it here: https://aur.archlinux.org/packages/ttf-inconsolata-g)
	set guifont=Inconsolata-g\ 16

  set guioptions="-mTrL"
  function! ToggleGUImenu()
    if &guioptions =~# 'm'
      exec('set guioptions-=m')
    else
      exec('set guioptions+=m')
    endif
  endfunction

  nnoremap <Leader>mm <Esc>:call ToggleGUImenu()<cr>
endif

" It appears that this is required to have spelling errors underlined in
" terminal vim...
hi SpellBad cterm=underline
" hi SpellBad gui=underline

"
" Settings, lettings and autocmds
"
set nocompatible           " use vim defaults
let g:mapleader=" "        " as it happens, <Space> does not work...
let &titleold=getcwd()     " so long, \"thanks for flying vim\"...

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
set hidden                 " don't unload (close?) buffers unless I tell you so!

" Command line completion. From 
" https://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names:
" > the first tab hit will complete as much as possible, the second tab hit
" > will provide a list [ and I don't use the rest of the example ]
set wildmode=longest,list

autocmd filetype help set nonumber                  " no line numbers when viewing help
autocmd filetype help nnoremap <buffer><cr> <c-]>   " Enter selects help subject
autocmd filetype help nnoremap <buffer><bs> <c-T>   " Backspace goes back
" File formats... 
au BufNewFile,BufRead  *.pls    set syntax=dosini
au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
" ... and ignores
set wildignore+=*.o,*.a,*.bak,*.pyc,*.class
set wildignore+=/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" show soft broken lines
set showbreak=…

""" tab stuff
set expandtab           " if you can't win...
set softtabstop =2      " in insert/edit, it is the <Space>-length of <Tab>
set tabstop     =2      " numbers of spaces of tab character (in view mode)
set shiftwidth  =2      " numbers of spaces to (auto)indent (eg << and >>)
set smarttab            " use shiftwidth when inserting Tab in line start
function! TabToggle()
  if &expandtab
    set noexpandtab
    echo "NOT expanding tabs!"
  else
    set expandtab
    echo "expanding tabs..."
  endif
endfunction
nnoremap <F9> :call TabToggle()<CR>
" and about VIM tabs
set tabpagemax=200 " XXX this might be removed in the future

" and line/paragraph stuff
set wrap
set linebreak
set breakindent
set nolist
set autoindent
set display=lastline    " dont hide paragraph behind @ signs, if whole para doesn't fit screen

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
" Shortcut to rapidly toggle `set list`
nmap <Leader><Leader> :set list!<CR> 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:•,nbsp:•


""" search
set noignorecase    " DO NOT ignore case when searching -> best default
set incsearch       " do incremental searching
set nohlsearch      " DO NOT highlight searches
" toggle set paste
set pastetoggle=<F8>

" when typing in terminal vim, skip Esc delay (by pressing other keys)
" NB: b0rks startinsert!
inoremap <Esc> <Esc>:<C-c>
vnoremap <Esc> <Esc>:<C-c>

"
" Maps, of all shapes and sizes!
"

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
inoremap <C-v> <Esc>:set paste<CR>"+p<F8>a
" NB: you can still insert '^V' (for literal char codes); 
" just do it in PASTE "mode" (i.e. press <F1>!).

" toggle relative line numbers
nnoremap <Leader>r :set invrelativenumber<CR>

" toggle hex mode
noremap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
noremap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>:w<CR>:e<CR>

" For long lines...
nnoremap ^ g^
nnoremap j gj
nnoremap k gk
nnoremap $ g$

" Manual solution for parenthesis et al. completion: 
" insert both, and then hit <left>, with a "closer" shortcut.
" The "right" shortcut is for when you want to continue past the delimiter.
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Tap :} to get {}. Very useful for custom commands!
" Similar maps for (), [], $$ and ** follow.
inoremap :} {}<Left>
inoremap :] []<Left>
inoremap :) ()<Left>
inoremap :$ $$<Left>
inoremap :* **<Left>

" Same for quotes
inoremap :" ""<Left>
inoremap :' ''<Left>

" And tap :backspace to delete the pair of braces/quotes
" if you got the wrong one (very common in practice!)
function! DeletePairedDelims()
  " When function is called, cursor is (in normal mode) over the opening delimiter.
  let l:col_open_delim = col(".")

  normal xx
  if col(".") == l:col_open_delim - 1 " if the delims ended the line, call append after deleting them
    startinsert!
  else " otherwise, call insert
    startinsert
  endif
endfunction
inoremap :<BS> <Esc>:call DeletePairedDelims()<CR>

" And of course, tap :: to actually get :
inoremap :: :

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

" for gundo
nnoremap <F4> :GundoToggle<CR><CR>

" narrow region
vnoremap <Leader>nn <Leader>nr<CR>
nnoremap <F3> <Plug>NrrwrgnWinIncr

" tagbar side bar
nnoremap <silent> <F12> :TagbarToggle<CR>
" also, to be able to jump to tag definition
nnoremap <leader>. :CtrlPTag<cr>

" DO NOT use conceal (appearently this only works if it is placed in vimrc)
let g:pandoc#syntax#conceal#use=0

" {{{ for status line (lightline)
set laststatus=2
let g:lightline = { 'colorscheme': 'solarized' }

let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste', 'noet', 'sw' ],
      \           [ 'readonly', 'filename', 'modified' ] ] }
let g:lightline.component_expand = {
      \ 'noet': 'LightlineNoexpandtab' }
let g:lightline.component_function = {
      \   'sw': 'LightlineShiftwidth' }
let g:lightline.component_type = {
      \   'noet': 'error' }
function! LightlineNoexpandtab()
  return &expandtab?'':'noet'
endfunction
function! LightlineShiftwidth()
  return &expandtab?'↹ '.&shiftwidth:''
endfunction

augroup lightline_update
  autocmd!
  autocmd OptionSet tabstop,shiftwidth,expandtab,paste :call lightline#update()
  autocmd Filetype * :call lightline#update()
augroup END
" }}} end lightline config

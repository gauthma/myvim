My vim configuration 
===

The name pretty much says it all. 
Requirements: 
--- 

- The **TeX-9** plugin requires that vim be compiled with python
	support. 
- My overall settings I use assume a slew of external
	programs: aspell, luatex (lualatex), bibtex, sudo, etc. These are not
	strictly necessary to use my vim settings; they are just programs that
	I use a lot, so they've ended up in my settings.
	
Install: 
--- 

``` bash 
$ wget https://raw.githubusercontent.com/gauthma/myvim/master/setup.sh
$ sh setup.sh
$ rm setup.sh
```

**NOTE**: this will ***DELETE*** any existing `~/.vim` and `~/.vimrc`,
so due care must be taken to back up any previous settings.

This installs (*most*; TODO fix this) the plugins. Here's the list I use
(adapt as needed). It also run `pathogen`'s `:Helptags`. Which in turn
runs `:helptags <plugin/doc>` for each directory in your runtime path.

- ctrlp
- DoxygenToolkit
- gundo
- NrrwRgn
- scss-syntax.vim -> https://github.com/cakebaker/scss-syntax.vim.git
- slimv
- snipMate
- surround
- tabular
- tagbar
- tex_nine
- The-NERD-tree
- vim-airline
- vim-colors-solarized
- vim-commentary
- vim-eunuch
- vim-pandoc-syntax
- vim-repeat

And presto, it's ready to use. Feedback on improvements is always welcome. Enjoy!

Information on the patches in the `customizations` folder can be
found on my Vim Hacks page, [here](http://erroneousthoughts.org/vim-hacks/).

Notes:
---
 - The config I use can be found here: https://github.com/gauthma/myvim
 - IMPORTANT: vim-pandoc requires that vim be compiled with python support. Otherwise, comment it out in vimrc!
 - when using LaTeX, pressing Esc *once* will keep the insert mode indication, but it will allow you to execute some normal mode commands, in particular saving the file (:w). I'm still working through the details

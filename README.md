My vim configuration 
===

The name pretty much says it all. 
Requirements: 
--- 

- The **TeX-9** plugin requires that vim be compiled with python support. 
- My overall settings I use assume a slew of external programs: aspell, luatex (lualatex), bibtex, sudo, etc. These are not strictly necessary to use my vim settings; they are just programs that I use a lot, so they've ended up in my settings.
	
Install: 
--- 

``` bash 
$ git clone https://github.com/gauthma/myvim.git myvim
$ sh myvim/setup.sh
$ rm -rf myvim
```

**NOTE**: this will ***DELETE*** any existing `~/.vim` and `~/.vimrc`, so due care must be taken to back up any previous settings.

This installs (*most*; TODO fix this) the plugins. The list of plugins I use can be seen in the file `~/.vim/customizations/vim_plugin_list` . The script also runs `pathogen`'s `:Helptags`. Which in turn runs `:helptags <plugin/doc>` for each directory in your runtime path.

And presto, it's ready to use. Feedback on improvements is always welcome. Enjoy!

Notes:
---
 - IMPORTANT: vim-pandoc requires that vim be compiled with python support. Otherwise, comment it out in vimrc!
 - when using LaTeX, pressing Esc *once* will keep the insert mode indication, but it will allow you to execute some normal mode commands, in particular saving the file (:w). I'm still working through the details

My vim configuration
===
The name pretty much says it all. 

Requirements:
---
 - The **TeX-9** plugin requires that vim be compiled with python support.
 - the settings i use assume a slew of external programms: aspell, luatex (lualatex), bibtex, sudo, etc. These are not  necessary to use my vim settings; they are just programs that I use a lot, so they've ended up in my settings.

Install:
---
```bash
$ mkdir -p ~/.vim/autoload ~/.vim/bundle;
$ curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
```

And presto, it's ready to use. Feedback on improvements is always welcome. Enjoy!

Notes:
---
 - The config I use can be found here: https://github.com/gauthma/myvim
 - IMPORTANT: vim-pandoc requires that vim be compiled with python support. Otherwise, comment it out in vimrc!
 - when using LaTeX, pressing Esc *once* will keep the insert mode indication, but it will allow you to execute some normal mode commands, in particular saving the file (:w). I'm still working through the details

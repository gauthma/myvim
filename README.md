My vim configuration
===

Install:
---
```bash
$ git clone git://github.com/gauthma/myvim.git ~/.vim
$ ln -s ~/.vim/vimrc ~/.vimrc
$ git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git
```

Next, enter vim, and in normal mode, do :BundleInstall
This will clone all the required plugins from their repos (github, et al.)

Further, from time to time, when you (or I) add new plugins, :BundleInstall
should be ran again. To check for new versions of existing plugins, and
update should they exist, run :BundleInstall!

More info here: http://www.charlietanksley.net/philtex/sane-vim-plugin-management/

The last step is to include custom snippets into the "proper" snippet files read by superSnipMate:

```bash
$ cd ~/.vim
$ for i in `ls customizations/code_snippets/` ; do cat customizations/code_snippets/$i >> bundle/superSnipMate/snippets/$i ; done
```

And presto, it's ready to use. Feedback on improvements is always welcome. Enjoy!

Notes:
---
 - The config I use can be found here: https://github.com/gauthma/myvim
 - IMPORTANT: vim-pandoc requires that vim be compiled with python support. Otherwise, comment it out in vimrc!
 - when using LaTeX, pressing Esc *once* will keep the insert mode indication, but it will allow you to execute some normal mode commands, in particular saving the file (:w). I'm still working through the details

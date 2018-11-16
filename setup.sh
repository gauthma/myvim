#! /bin/bash

GIT_CLONE_DIR=""

function get_cloned_dir {
  GIT_CLONE_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
  echo "Vim settings cloned in: ${GIT_CLONE_DIR}"
}

function do_setup {
  echo "Downloading plugins..."

  cd "${GIT_CLONE_DIR}"
  mkdir -p autoload bundle
  curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim

  # download plugins
  while read -r line ; do
    # skip blank or empty lines
    if [ -z "$line" -o "$line" == " " ]; then
      continue
    fi
    # skip comment lines... (which start with ")
    if [[ $line =~ ^\" ]]; then
      continue
    fi
    cd "${GIT_CLONE_DIR}"/bundle
    echo "Cloning $line..."
    git clone $line > /dev/null
    cd "${GIT_CLONE_DIR}"
  done < "./customizations/vim_plugin_list"
  # WARNING: do NOT put a tilde (~) in the above line, it will NOT work!
  cd "${GIT_CLONE_DIR}"
}

function customize {
  echo "Customizing..."
  cd "${GIT_CLONE_DIR}"

  # I just use the snippets in ~/.vim/snippets/
  rm -rf bundle/snipmate.vim/snippets

  # setup lightline.vim to my liking
  cd bundle/lightline.vim
  patch -p1 < ../../customizations/vim-lightline-background.patch
  cd "${GIT_CLONE_DIR}"

  # ditto for solarized
  cd bundle/vim-colors-solarized
  patch -p1 < ../../customizations/vim-colors-solarized.patch
  cd "${GIT_CLONE_DIR}"
}

function do_install {
  echo "WARNING! WARNING! WARNING!"
  echo "This will DELETE ~/.vimrc, ~/.vim, and ~/.gvimrc"
  read -p "Are you sure you want to continue? [type uppercase y]" -n 1 -r
  echo # (optional) move to a new line
  if [[ $REPLY =~ ^[Y]$ ]]; then
    rm -rf ~/.vimrc ~/.vim ~/.gvimrc
    cp -r . ~/.vim
    rm -f ~/.vim/setup.sh ~/.vim/README.md
    ln -s ~/.vim/vimrc ~/.gvimrc
  fi

  # Run :Helptags. This requires "execute pathogen#infect()" in ~/.vimrc, 
  # so can only be done after copying (install) stage.
  vim -c "Helptags|q"
}

get_cloned_dir
do_setup
customize
do_install

echo "Setup and install complete. You might wish to remove the git clone'd folder." 

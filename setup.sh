#! /bin/bash

function do_setup {
	rm -rf ~/.vimrc ~/.vim
	git clone https://github.com/gauthma/myvim.git ~/.vim
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	curl -LSso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
	ln -s ~/.vim/vimrc ~/.vimrc

	# download plugins
	cd
	while read -r line ; do
		# skip blank or empty lines
		if [ -z "$line" -o "$line" == " " ]; then
			continue
		fi
		# skip comment lines... (which start with ")
		if [[ $line =~ ^\" ]]; then
			continue
		fi
		cd ~/.vim/bundle
		echo "Cloning $line..."
		git clone $line > /dev/null
	done < ".vim/customizations/vim_plugin_list"
}

function postprocess {
	# I just use the TeX snippets in ~/.vim/snippets/
	rm ~/.vim/bundle/snipmate.vim/snippets/tex.snippets
	# ditto for the globals file...
	rm ~/.vim/bundle/snipmate.vim/snippets/_.snippets

	# run :Helptags
	vim -c "Helptags|q"
}

echo "WARNING! WARNING! WARNING!"
echo "This will DELETE both ~/.vimrc and ~/.vim."
read -p "Are you sure you want to continue? [Y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Y]$ ]]; then
	do_setup
	postprocess
fi

#!/usr/bin/env bash

git submodule init
git submodule update

DOTFILES="
    vim
    vimrc
    tmux.conf
    gitmux.conf
    bashrc
    bash_logout
    bash_profile
    psqlrc
    inputrc
    aws_shorthands
    zshrc
"


# Do the install
cd $(dirname $0)

for file in $DOTFILES; do
	echo "Linking $file"
    if [ "$(uname)" == "Darwin" ]; then
	    ln -sf $PWD/$file ~/.$file
    else
        ln -sfT $PWD/$file ~/.$file
    fi
done

# Run Vundle installs:
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

mkdir ~/.bash_logs # Needed by .bashrc
source ~/.bashrc

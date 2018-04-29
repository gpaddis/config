#!/bin/bash
# Link the files to the proper places.
# Always execute this script in the repo directory.

function makeSymLink {
    local origin="$1" destination="$2"
    if [ ! -f $destination ]
    then 
        ln -s $origin $destination
        echo "Linked $origin to $destination."
    else echo "The file $destination already exists."
    fi
}

makeSymLink $PWD/.vimrc $HOME/.vimrc
makeSymLink $PWD/plugins.vim $HOME/.vim/plugins.vim
makeSymLink $PWD/.aliases $HOME/.aliases

# Install Vundle if it is not present
if [ ! -d "$HOME/.vim/bundle/Vundle.vim"  ]; then
    echo "Vundle is not installed. Installation..."
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

#Install monokai theme
if [ ! -f "$HOME/.vim/colors/monokai.vim" ]; then
    echo "The monokai color scheme is not installed. Installation..."
    wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim -O $HOME/.vim/colors/monokai.vim
fi


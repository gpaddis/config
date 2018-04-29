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

#!/bin/bash
# Link the files to the proper places.
# Always execute this script in the repo directory.

GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Make a symlink to origin in destination if this does not exist
function makeSymLink {
    local origin="$1" destination="$2"
    if [ ! -f $destination ]
    then 
        ln -s $origin $destination
        printf "${GREEN}Linked $origin to $destination.${NC}\n"
    else printf "${GREEN}The file $destination already exists.${NC}\n"
    fi
}

# Check if a directory exists or create the full path
function checkOrMakeDir {
    local directory="$1"
    if [ ! -d $directory ]; then
        mkdir -p $directory
    fi
}

makeSymLink $PWD/.vimrc $HOME/.vimrc
makeSymLink $PWD/plugins.vim $HOME/.vim/plugins.vim
makeSymLink $PWD/.aliases $HOME/.aliases

checkOrMakeDir $HOME/.vim/colors

# Install Vundle if it is not present
if [ ! -d "$HOME/.vim/bundle/Vundle.vim"  ]; then
    printf "${GREEN}Vundle is not installed. Installation...${NC}\n"
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

#Install monokai theme
if [ ! -f "$HOME/.vim/colors/monokai.vim" ]; then
    printf "${GREEN}The monokai color scheme is not installed. Installation...${NC}\n"
    wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim -O $HOME/.vim/colors/monokai.vim
fi


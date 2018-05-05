#!/bin/bash
# Link the files to the proper places.
# Always execute this script in the repo directory.

GREEN='\033[0;32m'
NC='\033[0m' # No Color
VIMDIR="$HOME/.vim"

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

# If the destination file does not exist download from origin to destination
function checkOrDownload {
    local origin="$1" destination="$2" downloadCommand="wget"

    if [ ! -f $destination ]; then
        printf "${GREEN}Could not find $destination. Installation...${NC}\n"
        # Use wget or curl
        if [ $(command -v wget) ]
        then wget $origin -O $destination
        else curl -o $destination $origin
        fi
    fi
}

makeSymLink $PWD/.vimrc $HOME/.vimrc
makeSymLink $PWD/plugins.vim $VIMDIR/plugins.vim
makeSymLink $PWD/.aliases $HOME/.aliases

checkOrMakeDir $VIMDIR/colors

# Install Vundle if it is not present
if [ ! -d "$VIMDIR/bundle/Vundle.vim"  ]; then
    printf "${GREEN}Vundle is not installed. Installation...${NC}\n"
    git clone https://github.com/VundleVim/Vundle.vim.git $VIMDIR/bundle/Vundle.vim
fi

#Install color themes
checkOrDownload "https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim" "$VIMDIR/colors/monokai.vim"
checkOrDownload "https://raw.githubusercontent.com/skielbasa/vim-material-monokai/master/colors/material-monokai.vim" "$VIMDIR/colors/material-monokai.vim"
checkOrDownload "https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim" "$VIMDIR/colors/atom-dark-256.vim"
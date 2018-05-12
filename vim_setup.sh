#!/bin/bash
# Link the files to the proper places.
# Always execute this script in the repo directory.

GREEN='\033[0;32m'
NC='\033[0m' # No Color
VIMDIR="$HOME/.vim"

source bash_functions.sh

makeSymLink $PWD/.vimrc $HOME/.vimrc
makeSymLink $PWD/plugins.vim $VIMDIR/plugins.vim
makeSymLink $PWD/.aliases $HOME/.aliases

# Link the snippets
checkOrMakeDir $VIMDIR/snippets
makeSymLink $PWD/snippets/php.snippets $VIMDIR/snippets/php.snippets

checkOrMakeDir $VIMDIR/colors

# Install Vundle if it is not present
if [ ! -d "$VIMDIR/bundle/Vundle.vim"  ]; then
    printf "${GREEN}Vundle is not installed. Installation...${NC}\n"
    git clone https://github.com/VundleVim/Vundle.vim.git $VIMDIR/bundle/Vundle.vim
fi

# Install color themes
checkOrDownload "https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim" "$VIMDIR/colors/monokai.vim"
checkOrDownload "https://raw.githubusercontent.com/skielbasa/vim-material-monokai/master/colors/material-monokai.vim" "$VIMDIR/colors/material-monokai.vim"
checkOrDownload "https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim" "$VIMDIR/colors/atom-dark-256.vim"
checkOrDownload "https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim" "$VIMDIR/colors/badwolf.vim"

# Install all Vundle plugins
vim +PluginInstall +qall
vim +PluginInstall +qall # Sometimes once is not enough.

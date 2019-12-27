#!/bin/bash
# Link the files to the proper places.
# Always execute this script in the repo directory.

VIMDIR="$HOME/.vim"

source bash_functions.sh

makeSymLink $PWD/.vimrc $HOME/.vimrc
makeSymLink $PWD/plugins.vim $VIMDIR/plugins.vim
makeSymLink $PWD/.aliases $HOME/.aliases

# Link the snippets
[ -d $VIMDIR/UltiSnips ] || makeSymLink $PWD/UltiSnips $VIMDIR/UltiSnips

checkOrMakeDir $VIMDIR/tmp
checkOrMakeDir $VIMDIR/colors

# Install Vundle if it is not present
if [ ! -d "$VIMDIR/bundle/Vundle.vim"  ]; then
    printGreen "Vundle is not installed. Installation..."
    git clone https://github.com/VundleVim/Vundle.vim.git $VIMDIR/bundle/Vundle.vim
fi

# Install color themes
checkOrDownload "https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim" "$VIMDIR/colors/monokai.vim"
checkOrDownload "https://raw.githubusercontent.com/skielbasa/vim-material-monokai/master/colors/material-monokai.vim" "$VIMDIR/colors/material-monokai.vim"
checkOrDownload "https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim" "$VIMDIR/colors/atom-dark-256.vim"
checkOrDownload "https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim" "$VIMDIR/colors/badwolf.vim"

# Clean all old Vundle plugins and install the new ones.
vim +PluginClean +qall
vim +PluginInstall +qall

# Reminders
[ -d $VIMDIR/bundle/YouCompleteMe ] && printGreen "YouCompleteMe is installed: run install.py in the plugin directory if you haven't already (check the docs: https://github.com/ycm-core/YouCompleteMe)."

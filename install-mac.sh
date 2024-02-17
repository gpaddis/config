#!/bin/bash

. bash_functions.sh

# Install missing software with homebrew.
installIfMissing() {
    commandNotFound "$1" && brew install "$1"
}

commandNotFound brew && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

installIfMissing fd
installIfMissing jq
installIfMissing zim
installIfMissing tmux
installIfMissing ncdu
installIfMissing openvpn
installIfMissing goaccess

commandNotFound http && brew install httpie
commandNotFound fzf && brew install fzf && $(brew --prefix)/opt/fzf/install
[ -z $(brew list | grep coreutils) ] && brew install coreutils

printGreen "Installation complete."

# Save the SSH passphrase in the Keychain.
grep 'UseKeychain yes' $HOME/.ssh/config || {
    echo -e "Host *\n    UseKeychain yes\n    AddKeysToAgent yes\n    IdentityFile ~/.ssh/id_ed25519" >> $HOME/.ssh/config
}

# Install plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Configure neovim
ln -s .vimrc ~/.vimrc
mkdir -p  ~/.config/nvim/
cat <<EOT >> ~/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOT

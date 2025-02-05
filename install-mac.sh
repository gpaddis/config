#!/bin/bash

. bash_functions.sh

# Install missing software with homebrew.
installIfMissing() {
    commandNotFound "$1" && brew install "$1"
}

commandNotFound brew && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
commandNotFound zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

installIfMissing fd
installIfMissing jq
installIfMissing zim
installIfMissing nvim
installIfMissing tmux
installIfMissing ncdu
installIfMissing openvpn
installIfMissing goaccess
installIfMissing redis
installIfMissing git-absorb

commandNotFound http && brew install httpie
commandNotFound fzf && brew install fzf && $(brew --prefix)/opt/fzf/install
[ -z $(brew list | grep coreutils) ] && brew install coreutils

fileNotFound $HOME/.ssh/id_ed25519 && {
    echo -n "Enter your email: "
    read EMAIL_ADDRESS
    ssh-keygen -t ed25519 -C $EMAIL_ADDRESS
}

# Save the SSH passphrase in the Keychain.
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
grep -q 'UseKeychain yes' $HOME/.ssh/config || {
    eval "$(ssh-agent -s)"
    echo -e "Host *\n    UseKeychain yes\n    AddKeysToAgent yes\n    IdentityFile ~/.ssh/id_ed25519" >> $HOME/.ssh/config
    ssh-add --apple-use-keychain $HOME/.ssh/id_ed25519
}

# Install plugins
dirNotFound ~/.vim/bundle/Vundle.vim && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
dirNotFound ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fileNotFound $HOME/.aliases && ln -s .aliases $HOME/.aliases
grep -q '.aliases' $HOME/.zshrc || echo "source .aliases" >> $HOME/.zshrc

# Configure neovim
fileNotFound $HOME/.vimrc && ln -s .vimrc $HOME/.vimrc
mkdir -p  $HOME/.config/nvim/
fileNotFound $HOME/.config/nvim/init.vim && cat <<EOT > $HOME/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOT

printGreen "Installation complete."

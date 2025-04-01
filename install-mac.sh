#!/bin/bash

set -e

. bash_functions.sh

# Install missing software with homebrew.
commandNotFound brew && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
commandNotFound zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

ln -s "$DOTFILES/Brewfile" "$HOME/Brewfile"
cd $HOME
brew bundle

fileNotFound $HOME/.ssh/id_ed25519 && {
  echo -n "Enter your email: "
  read EMAIL_ADDRESS
  ssh-keygen -t ed25519 -C $EMAIL_ADDRESS
}

# Save the SSH passphrase in the Keychain.
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
grep -q 'UseKeychain yes' $HOME/.ssh/config || {
  eval "$(ssh-agent -s)"
  echo -e "Host *\n    UseKeychain yes\n    AddKeysToAgent yes\n    IdentityFile ~/.ssh/id_ed25519" >>$HOME/.ssh/config
  ssh-add --apple-use-keychain $HOME/.ssh/id_ed25519
}

# Configure Tmux
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf
dirNotFound ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fileNotFound $HOME/.aliases && ln -s "$DOTFILES/.aliases" "$HOME/.aliases"
grep -q '.aliases' $HOME/.zshrc || echo "source .aliases" >>$HOME/.zshrc

# Configure neovim
mkdir -p $HOME/.config/nvim/
ln -snf $DOTFILES/init.lua $HOME/.config/nvim/init.lua

# Configure git
touch ~/.gitignore
git config --global core.excludesFile '~/.gitignore'
git config --global user.name 'Gianpiero Addis'
git config --global user.email $EMAIL_ADDRESS
git config --global merge.conflictstyle diff3

printGreen "Installation complete."

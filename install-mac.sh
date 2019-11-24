#!/bin/bash

. bash_functions.sh

# Install missing software with homebrew.
installIfMissing() {
    commandNotFound "$1" && brew install "$1"
}

commandNotFound brew && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

installIfMissing fd
installIfMissing zim
installIfMissing tmux
installIfMissing goaccess

commandNotFound http && brew install httpie
commandNotFound fzf && brew install fzf && $(brew --prefix)/opt/fzf/install

printGreen "Installation complete."
exit 0

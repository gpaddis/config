#!/bin/bash

. bash_functions.sh

commandNotFound brew && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

commandNotFound zim && brew install zim
commandNotFound fzf && {
    brew install fzf
    $(brew --prefix)/opt/fzf/install
}

printGreen "Installation complete."
exit 0

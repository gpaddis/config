# Install the software required.

sudo apt update && sudo apt upgrade -y

sudo apt remove vim-tiny -y

sudo apt install vim vim-gtk xclip dia -y

# Install Zsh, make it the default shell, install oh-my-zsh

if [ ! $SHELL = '/usr/bin/zsh' ]; then
    sudo apt install zsh -y
    chsh -s $(which zsh)

    # Install oh-my-zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
else echo "Zsh is already installed."
fi


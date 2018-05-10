# Install the software required.

sudo apt update && sudo apt upgrade -y

sudo apt remove vim-tiny -y

sudo apt install vim vim-gtk xclip dia curl -y

# Install Zsh, make it the default shell, install oh-my-zsh
if [ ! $SHELL = '/usr/bin/zsh' ]; then
    sudo apt install zsh -y
    chsh -s $(which zsh)

    # Install oh-my-zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
else echo "Zsh is already installed."
fi

# Check if MS VS Code is installed
if ! type "code" > /dev/null; then
    # Add key and repository
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    # Install code
    sudo apt-get update
    sudo apt-get install code -y
else echo "Code is already installed."
fi


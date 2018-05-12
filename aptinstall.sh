# Add Repositories and Keys
# VS Code 
if ! type "code" > /dev/null; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
fi

# Install the software required.
sudo apt update && sudo apt upgrade -y

sudo apt remove vim-tiny -y

sudo apt install vim vim-gtk colordiff xclip dia curl zim code zsh keepassx terminator fonts-powerline -y

# Make zsh the default shell, install oh-my-zsh
if [ ! $SHELL = '/usr/bin/zsh' ]; then
    $ZSHRC = $HOME/.zshrc

    chsh -s $(which zsh)
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

    # Set the default user in the .zshrc
    echo "# Hide the default user name from the prompt" >> $ZSHRC
    echo DEFAULT_USER=\"$USER\" >> $ZSHRC

    # Use agnoster theme instead of default (robbyrussell)
    sed -i -e 's/robbyrussell/agnoster/g' $ZSHRC 

    # Import the custom aliases
    echo "source ~/.aliases" >> $ZSHRC
fi


#!/bin/bash
# Resources:
# * https://remysharp.com/2018/08/23/cli-improved

. bash_functions.sh

# Get Ubuntu codename - in case something needs to be installed for a specific Ubuntu version
UBUNTU_CODENAME="$(lsb_release -c | awk '{print $NF}')"

# Initialization
ZSHRC=$HOME/.zshrc
checkOrMakeDir "$HOME/bin"

# Import the custom aliases
appendStringToFile "source ~/.aliases" $ZSHRC

# Install the software required.
sudo apt update && sudo apt upgrade -y

sudo apt remove -y vim-tiny

# Basic packages
sudo apt install -y curl vim vim-gtk colordiff xclip tree curl zim code zsh keepassx fonts-powerline build-essential cmake python-dev python3-dev oathtool gnupg2 fdupes gitk sqlitebrowser htop geoip-bin ncdu tmux golang-go jq docker docker-compose

# Optional packages
sudo apt install -y fd-find

# VS Code
if commandNotFound code; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
fi

# Install fzf (https://github.com/junegunn/fzf)
if [ ! -d $HOME/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
fi

# Install cht.sh
if fileNotFound "$HOME/bin/cht.sh"; then
    curl https://cht.sh/:cht.sh > $HOME/bin/cht.sh
    chmod +x $HOME/bin/cht.sh
fi

# Make zsh the default shell, install oh-my-zsh
if [ ! $SHELL = '/usr/bin/zsh' ]; then
    chsh -s $(which zsh)
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

    # Set the default user in the .zshrc
    appendStringToFile "# Hide the default user name from the prompt" $ZSHRC
    appendStringToFile "DEFAULT_USER=\"$USER\"" $ZSHRC
fi

# Install PHPUnit 5, 6, 7
for i in $(seq 5 7);
do
    if commandNotFound "phpunit$i"; then
        sudo wget -O /usr/local/bin/phpunit$i https://phar.phpunit.de/phpunit-$i.phar
        sudo chmod +x /usr/local/bin/phpunit$i
        printGreen "Installed phpunit$i.\n"
    fi
done

# Install Codeception
if commandNotFound codecept; then
    sudo curl -LsS https://codeception.com/codecept.phar -o /usr/local/bin/codecept
    sudo chmod a+x /usr/local/bin/codecept
    printGreen "Installed Codeception.\n"
fi

# Install Tmux Plugin Manager
if fileNotFound "$HOME/.tmux/plugins/tpm/tpm"; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    printGreen "Installed Tmux Plugin Manager.\n"
fi

# Install Tmuxinator
if commandNotFound tmuxinator; then
    sudo gem install tmuxinator
    printGreen "Installed tmuxinator.\n"
fi

tmuxinatorCompletion="$HOME/bin/tmuxinator.zsh"
if fileNotFound "$tmuxinatorCompletion"; then
    wget -O $tmuxinatorCompletion https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh
    chmod +x $tmuxinatorCompletion
    appendStringToFile "source $tmuxinatorCompletion" $ZSHRC
    printGreen "Tmuxinator completion added to path."
fi

#!/bin/bash
echo "Setting up zsh..."

MARK="ToxblhZshRc"
RESTART="Done. Please restart your terminal to apply changes and run main.sh again"

# check is zsh installed in /bin/zsh or /usr/bin/zsh

if [[ ! -f /usr/bin/zsh ]]; then
    echo "Zsh is not installed. Installing..."
    install_zsh
fi

# install zsh
function install_zsh() {
    if [[ -f /usr/bin/yum ]]; then
        sudo yum install zsh -y
    elif [[ -f /usr/bin/dnf ]]; then
        sudo dnf install zsh -y
    elif [[ -f /usr/bin/apt ]]; then
        sudo apt-get install zsh -y
    fi
}

# change shell to zsh
if [[ ! $SHELL == "/usr/bin/zsh" ]]; then
    echo "Changing shell to zsh..."
#    chsh -s $(which zsh)
fi

if [[ -f ~/.zshrc ]];then
    if grep -q $MARK ~/.zshrc; then
        while true; do
            read -p "Zshrc already installed, re-install? [Y/n] " yn
            case $yn in
                [Yy]* ) break;;
                [Nn]* ) exit 0;;
                * ) echo "Please answer Y or N.";;
            esac
        done
    fi
fi

echo "Zshrc not installed. Installing..."
cp ./configs/.zshrc ~/.zshrc
echo $RESTART
exit 1

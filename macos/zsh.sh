echo "Setting up zsh..."

MARK="ToxblhZshRc"
RESTART="Done. Please restart your terminal to apply changes and run main.sh again"

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

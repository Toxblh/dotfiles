# change shell to zsh
if [[ ! $SHELL == "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

cp ./configs/.gitconfig ~/.gitconfig


# Zsh
./zsh.sh

# check zsh.sh status. 0 - ok, 1 - need restart
if [[ $? -eq 1 ]]; then
    exit 0
fi

# Brew
./brew/apps.sh 
./brew/rust.sh
./brew/nvm.sh
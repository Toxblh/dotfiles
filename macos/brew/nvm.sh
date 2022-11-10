echo "NVM and Node init..."
source ~/.nvm/nvm.sh

if [[ ! -d ~/.nvm/versions/node ]]; then
    nvm install --lts --default
else
    echo "Node already installed"
fi

if (npm list -g | grep yarn -q) then
    echo "Yarn already installed"
else
    echo "Installing yarn..."
    npm install -g yarn
fi
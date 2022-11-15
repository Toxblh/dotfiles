RESTART="Done. Please restart your terminal to apply changes and run main.sh again"

# brew
if [[ ! ( -f /opt/homebrew/bin/brew || -f /usr/local/bin/brew ) ]]; then
    echo "Brew not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo $RESTART
    exit 1
fi

echo "Brew installing apps..."

# fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font

# pass
brew install --cask bitwarden
brew install --cask 1password

# messangers
brew install --cask telegram
brew install --cask discord
brew install --cask element

# code
brew install --cask visual-studio-code
brew install --cask db-browser-for-sqlite

# cli tools
brew install lsd
brew install tldr
brew install git
brew install httpie
brew install python3
brew install binwalk
brew install jq

## node
brew install nvm

## rust
brew install rustup

# others
brew install --cask monitorcontrol
brew install --cask simplenote
brew install --cask todoist
brew install --cask coconutbattery
brew install --cask firefox
brew install --cask thunderbird
brew install --cask spotify
brew install --cask obsidian
brew install --cask vlc

echo "Brew installed!"
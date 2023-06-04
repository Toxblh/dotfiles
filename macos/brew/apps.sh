RESTART="Done. Please restart your terminal to apply changes and run main.sh again"

# brew
if [[ ! ( -f /opt/homebrew/bin/brew || -f /usr/local/bin/brew ) ]]; then
    echo "Brew not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo $RESTART
    exit 1
fi

echo "Brew installing apps..."

# taps
brew tap homebrew/cask-fonts

####
# Install Casks
####

# fonts
brew install --cask \
    font-fira-code \
    font-fira-code-nerd-font \
`# pass` \
    bitwarden \
    1password \
`# messangers` \
    telegram \
    discord \
    element \
`# code` \
    visual-studio-code \
    db-browser-for-sqlite \
`# others` \
    monitorcontrol \
    simplenote \
    todoist \
    coconutbattery \
    firefox \
    thunderbird \
    spotify \
    obsidian \
    vlc \
    hiddenbar \
    microsoft-remote-desktop \
    krita \
    alacritty

####
# cli tools
####
brew install \
    lsd \
    tldr \
    git \
    httpie \
    python3 \
    binwalk \
    jq \
    stats \
`## node` \
    nvm \
`## rust` \
    rustup \



echo "Brew installed!"
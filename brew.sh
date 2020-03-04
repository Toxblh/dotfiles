# brew install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# APPS
brew cask install simplenote
brew cask install mtmr
brew cask install monitorcontrol
brew cask install tunnelblick

# Dev Tools
brew install watch
brew install nvm
brew install httpie
brew install python3

brew install tldr
brew install git
brew install diff-so-fancy
brew install gnupg

# Kube
brew install kubectx
brew tap robscott/tap
brew install robscott/tap/kube-capacity

# GC-SDK + K8s
brew cask install google-cloud-sdk
brew install helm

# install helm 2.15.0
# git clone https://github.com/Homebrew/homebrew-core.git
# cd homebrew-core
# brew install https://github.com/Homebrew/homebrew-core/raw/560afd4e62f4b84113de9b27626325ded28abb87/Formula/kubernetes-helm.rb

# VPN
# brew install wireguard-go

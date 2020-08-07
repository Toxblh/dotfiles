ZSH config

# Install ZSH and Oh-my-zsh
# ZSH:            https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
# Oh-my-zsh:      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Change shell:   chsh -s $(which zsh)
# Test:           echo $SHELL
# Finish          zsh

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export TERM="xterm-256color"
# powerlevel9k/10k
# git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator vcs battery time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

plugins=(
  git

# zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  zsh-autosuggestions

# zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Add Visual Studio Code (code)
# export PATH="\$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

# K8s
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
if [ /usr/local/bin/helm ]; then source <(helm completion zsh); fi

# The next line updates PATH for the Google Cloud SDK and enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# The next line updates PATH for the NVM.
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
# export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"

export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export ANDROID_HOME="~/Library/Android/sdk"
export GEM_HOME=$HOME/gems
export PATH=$PATH:~/.local/bin
export PATH=$HOME/gems/bin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/opt/python@2/libexec/bin:$PATH

alias debugChrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222"
alias beautify="npx prettier --print-width 90 --no-semi --single-quote --trailing-comma all --write \"**/*.js\" && npx prettier --print-width 90 --no-semi --single-quote --trailing-comma all --write \"**/*.json\""
alias beautifyALL="prettier --write --print-width 90 --no-semi --single-quote --trailing-comma all **/*.{js,jsx,ts,tsx,json,css,pcss,less,sass,scss,md,yml,gql,graphql,mdx}"
alias pip3="python3 -m pip"
alias cat="bat"
alias k="kubectl"
alias kx="kubectx"

export PATH="/usr/local/opt/helm@2/bin:$PATH"

export TERM="xterm-256color"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator vcs battery time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito'

# ZPlug

if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

# Theme
zplug romkatv/powerlevel10k, as:theme

# Aliases
zplug "robbyrussell/oh-my-zsh", as:plugin, use:"lib/*.zsh"

# Plugins
zplug "plugins/archlinux",         from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize",          from:oh-my-zsh
zplug "lib/completion",            from:oh-my-zsh
zplug "lib/history",               from:oh-my-zsh
zplug "lib/key-bindings",          from:oh-my-zsh
zplug "lib/termsupport",           from:oh-my-zsh
zplug "lib/directories",           from:oh-my-zsh
zplug "plugins/git",               from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
# zplug "zsh-users/zsh-syntax-highlighting"
zplug "zdharma/fast-syntax-highlighting" # Работает намного быстрее предыдущего плагина и подсвечивает лучше
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-you-should-use" # Сообщает о том, что для команды существует алиас

zplug check || zplug install
zplug load

source /usr/share/nvm/init-nvm.sh

alias k=kubectl
alias ktx=kubectx
alias disablesleep="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias enablesleep="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias ls="ls --color"
alias l="lsd --date '+%d.%m.%Y %H:%M' -lah"

neofetch

export PATH=~/.cargo/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/toxblh/.sdkman"
[[ -s "/home/toxblh/.sdkman/bin/sdkman-init.sh" ]] && source "/home/toxblh/.sdkman/bin/sdkman-init.sh"

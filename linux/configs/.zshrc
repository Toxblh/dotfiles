# ToxblhZshRc
export TERM="xterm-256color"
export LC_ALL=en_GB.UTF-8

# PATH set early
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/flutter/bin:$HOME/scripts:$HOME/.lmstudio/bin:$HOME/.local/lib/python3/site-packages:$PATH"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator vcs battery time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito'

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Theme (load synchronously for instant prompt)
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Oh-my-zsh libs & plugins (turbo mode — load after prompt)
zinit wait lucid for \
    OMZL::functions.zsh \
    OMZL::completion.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::termsupport.zsh \
    OMZL::directories.zsh \
    OMZP::colored-man-pages \
    OMZP::colorize \
    OMZP::git \
    OMZP::history

# Plugins (turbo mode)
zinit wait lucid for \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/fast-syntax-highlighting

alias disablesleep="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias enablesleep="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias ls="ls --color"
alias l="lsd --date '+%d.%m.%Y %H:%M' -lah"
alias enhance='function ne() { docker run --rm -v "$(pwd)/`dirname ${@:$#}`":/ne/input -it alexjc/neural-enhance ${@:1:$#-1} "input/`basename ${@:$#}`"; }; ne'
alias logout="loginctl terminate-user toxblh"
alias convert="find . -name '*.mp4' -execdir ffmpeg -i '{}' -c:v mpeg4 -qscale:v 4 -c:a pcm_s32le {}-davinci.mov \;"
alias convertM="find . -name '*.webm' -execdir ffmpeg -i '{}' -c:v copy -c:a pcm_s32le {}-davinci.mp4 \;"
alias chmox="chmod +x"
alias open="xdg-open"
alias say="espeak-ng"
alias sayru="espeak-ng -v ru"
alias zed="zed-editor"

meson() {
    if [[ "$1" == "build" || "$1" == "setup" ]]; then
        local MESON_BUILD="meson.build"
        local LOCK_FILE="epm.lock"

        if [[ -f "$MESON_BUILD" ]]; then
            local DEPS=$(grep -rhoP "dependency\('\K[^']+" . --include="meson.build" 2>/dev/null \
                | sort -u)
            # local DEPS=$(grep -oP "dependency\('\K[^']+" "$MESON_BUILD" | sort)
            local DEPS_HASH=$(echo "$DEPS" | md5sum | cut -d' ' -f1)

            local need_install=true
            if [[ -f "$LOCK_FILE" ]]; then
                local LOCK_HASH=$(grep "^hash:" "$LOCK_FILE" | cut -d' ' -f2)
                [[ "$DEPS_HASH" == "$LOCK_HASH" ]] && need_install=false
            fi

            if $need_install; then
                echo "→ installing deps..."
                if epmi $(echo "$DEPS" | sed "s/.*/pkgconfig(&)/"); then
                    {
                        echo "hash: $DEPS_HASH"
                        echo "date: $(date -Iseconds)"
                        echo "deps:"
                        echo "$DEPS" | sed "s/^/  - /"
                    } > "$LOCK_FILE"
                    echo "✓ lock updated"
                else
                    echo "⚠ install failed, lock not updated"
                fi
            fi
        fi
    fi

    command meson "$@"
}

export SSH_AUTH_SOCK=$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock
# export SSH_AUTH_SOCK=~/.1password/agent.sock

zinit wait lucid atload'eval "$(atuin init zsh)"' for zdharma-continuum/null

fastfetch

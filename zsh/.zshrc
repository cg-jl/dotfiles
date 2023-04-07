# cd to directory when written as a command
setopt autocd

add-to-path() {
	export -U PATH=$1${PATH:+:$PATH}
}

add-to-ldpath() {
    export -U LD_LIBRARY_PATH=$1${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
}

add-to-path /opt/bin
add-to-ldpath /opt/lib
add-to-path $HOME/.cargo/bin
add-to-path $HOME/go/bin
add-to-path $HOME/.local/bin

if command -v "direnv" >/dev/null 2>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# set XDG prefixes
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# git stuff
export GIT_EDITOR=nvim
alias gap='git add --patch'
alias gst='git status'
alias gpf='git push --force-with-lease'

# bat theme
export BAT_THEME="Catppuccin-mocha"

# ls alias
alias ls='ls --color=auto'
alias ll='ls -lA'

pure-prompt() {
    fpath+=("$HOME/.zsh/pure")
    autoload -U promptinit
    promptinit
    prompt pure
}

# syntax highlighting + autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# starship prompt
starship-prompt() {
    source <(starship init zsh --print-full-init)
}
starship-prompt


load-nvm() {
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" 
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm if [ -s "$NVM_DIR"]
}

# opam configuration
if [[ -r /home/gsus/.opam/opam-init/init.zsh ]]; then source /home/gsus/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null; fi

if [ -f "/home/gsus/.ghcup/env" ]; then source "/home/gsus/.ghcup/env"; fi # ghcup-env

if [ -e /home/gsus/.nix-profile/etc/profile.d/nix.sh ]; then . /home/gsus/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

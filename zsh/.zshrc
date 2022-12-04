# cd to directory when written as a command
setopt autocd

add-to-path() {
	export -U PATH=$1${PATH:+:$PATH}
}

add-to-path $HOME/.cargo/bin
add-to-path $HOME/go/bin
add-to-path $HOME/.local/bin

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
alias ls='lsd --color=auto'
alias ll='ls -lA'

# syntax highlighting + autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# starship prompt
source <(starship init zsh --print-full-init)

# opam configuration
[[ ! -r /home/gsus/.opam/opam-init/init.zsh ]] || source /home/gsus/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f "/home/gsus/.ghcup/env" ] && source "/home/gsus/.ghcup/env" || true # ghcup-env

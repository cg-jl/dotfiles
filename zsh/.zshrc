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

# bat theme
export BAT_THEME=OneHalfDark

# ls alias
alias ls='lsd --color=auto'
alias ll='ls -lA'

# syntax highlighting + autosuggestions
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship prompt
source <(starship init zsh --print-full-init)

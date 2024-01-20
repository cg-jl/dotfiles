# cd to directory when written as a command
setopt autocd


typeset -T LD_LIBRARY_PATH ldlibpath

add-to-path() {
    path=($1 $path)
}



ldpath+=(/opt/lib /opt/riscv/lib /usr/lib)
path=(/opt/jdtls/bin /opt/riscv/bin /opt/bin $HOME/.cargo/bin $HOME/go/bin $HOME/.local/bin $path)


export OPAMROOT="/run/media/cg/langs/.opam"

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
alias gs='git status'
alias gpf='git push --force-with-lease'
alias gcan='git commit --amend --no-edit'
alias gca='git commit --amend'
alias gc.='git commit'
alias gr.='git restore'
alias gud='git diff'
alias gra='git rebase -i'
alias cachegrind='valgrind --tool=callgrind'

# ls alias
alias ls='ls --color=auto'
alias ll='ls -lAh'

alias v='nvim'

pure-prompt() {
    fpath+=("$HOME/.zsh/pure")
    autoload -U promptinit
    promptinit
    prompt pure
}
pure-prompt

# syntax highlighting + autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh


# opam configuration
if [[ -r $OPAMROOT/opam-init/init.zsh ]]; then source $OPAMROOT/opam-init/init.zsh  > /dev/null 2> /dev/null; fi

# direnv
eval "$(direnv hook zsh)"

# zoxide
which  zoxide >/dev/null && eval "$(zoxide init zsh)"

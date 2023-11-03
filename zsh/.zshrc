# cd to directory when written as a command
setopt autocd


typeset -T LD_LIBRARY_PATH ldlibpath

add-to-path() {
    path=($1 $path)
}



ldpath+=(/opt/lib /usr/lib)
path=(/opt/bin $HOME/.cargo/bin $HOME/go/bin $HOME/.local/bin $HOME/sw/install/llvm/bin $HOME/sw/install/neovim/bin $path)

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
alias gra='git rebase -i'

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

# starship prompt
starship-prompt() {
    source <(starship init zsh --print-full-init)
}


load-nvm() {
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" 
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm if [ -s "$NVM_DIR"]
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# opam configuration
if [[ -r /home/cg/.opam/opam-init/init.zsh ]]; then source /home/cg/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null; fi

# direnv
eval "$(direnv hook zsh)"

# bun completions
[ -s "/home/cg/.bun/_bun" ] && source "/home/cg/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zoxide
which  zoxide >/dev/null && eval "$(zoxide init zsh)"

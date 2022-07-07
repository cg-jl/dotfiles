# cd to directory when written as command
setopt autocd

add-to-path() {
  export -U PATH=$1${PATH:+:$PATH}
}


add-to-path $HOME/.cargo/bin
add-to-path $HOME/go/bin
add-to-path $HOME/.local/bin
add-to-path $HOME/.composer/vendor/bin
add-to-path $HOME/.local/neovim/bin

# set XDG prefixes
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"


export GIT_EDITOR=nvim
export BAT_THEME="base16"

# set a correct format for `time`:
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
# ls alias
alias ls='lsd --color=auto'


# starship prompt
source <(/home/gsus/.cargo/bin/starship init zsh --print-full-init)
# syntax highlighting
source ~/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh

# git aliases
alias gap="git add --patch"
alias gst="git status"
alias gpf="git push --force-with-lease"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
if [ -e /home/gsus/.nix-profile/etc/profile.d/nix.sh ]; then . /home/gsus/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
[ -f "/home/gsus/.ghcup/env" ] && source "/home/gsus/.ghcup/env" # ghcup-env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval $(thefuck --alias)

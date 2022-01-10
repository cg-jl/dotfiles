# cd to directory when written as command
setopt autocd

add-to-path() {
  export -U PATH=$1${PATH:+:$PATH}
}


add-to-path $HOME/.cargo/bin
add-to-path $HOME/go/bin
add-to-path $HOME/.local/bin
add-to-path $HOME/.composer/vendor/bin
# TODO: make something to use the toolchain that is relevant to the project
add-to-path $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin

export GIT_EDITOR=nvim
export BAT_THEME="gruvbox-dark"

# set a correct format for `time`:
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
# ls alias
alias ls='lsd -l --color=auto'

# starship prompt
source <(/home/gsus/.cargo/bin/starship init zsh --print-full-init)
# syntax highlighting
source ~/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh

alias gap="git add --patch"
alias dots="git --git-dir=$HOME/.cfg --work-tree=$HOME"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
if [ -e /home/gsus/.nix-profile/etc/profile.d/nix.sh ]; then . /home/gsus/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
[ -f "/home/gsus/.ghcup/env" ] && source "/home/gsus/.ghcup/env" # ghcup-env
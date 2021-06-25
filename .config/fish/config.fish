#!/bin/fish

set -g EDITOR nvim
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
export MANPAGER="nvim -c 'set ft=man' -"
xset r rate 300 50 # faster scrolling with keys

# so that github cli doesn't launch nano again, duh
set -g GIT_EDITOR nvim

function add-to-path --argument dir --description "adds argument to path if it doesn't exist in path yet."
  if test -d $dir
    if not contains -- $dir $PATH
      set -p PATH $dir
    end
  end
end

add-to-path /opt/bin
add-to-path ~/.local/bin
add-to-path ~/.ghcup/bin
add-to-path ~/.tmux/bin
add-to-path ~/go/bin
add-to-path ~/.cargo/bin


## Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# ## Fish command history
# function history
#     builtin history --show-time='%F %T '
# end

function backup --argument filename
    cp $filename $filename.bak
end

function mkcd --description "Makes the directories if they don't exist and cd's to the last one."
  pushd .
  for arg in $argv
    popd
    mkdir -p $arg
    pushd $arg
  end
end



alias ls='lsd -l --color=auto'
alias la='lsd -a --color=auto'
alias ll='lsd -al --color=auto'
alias lt='lsd -aT --color=always'

# alias please='sudo'
# alias tb='nc termbin.com 9999'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"



source "$HOME/.config/fish/git_aliases.fish"

source ("/usr/bin/starship" init fish --print-full-init | psub)

# tmux + fzf = <3
export FZF_TMUX_OPTS="-p"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

thefuck --alias | source

status --is-interactive; and jfetch


function tmux --description "override tmux"
  /usr/bin/tmux -2 $argv
end


# vim:ft=fish


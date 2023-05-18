# https://nix-community.github.io/home-manager/options.html
{pkgs,  ...}: {
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [ "CodeNewRoman" ];
    })
    pkgs.wl-clipboard
  ];
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  # todo: gtk.cursortheme
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    # don't forget to add 
    # environment.pathsToLink = [ "/share/zsh" ]
    # to system configuration to get completion for system packages
    enableCompletion = true;
    autocd = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lA";
      gap = "git add --patch";
      gst = "git status";
      gpf = "git push --force-with-lease";
    };
    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "2f13dea466466dde1ba844ba5211e7556f4ae2db";
          sha256 = "1n5n8yi5slzhygsl0g5a633m1vsafmja3pyaklnz61l0l16arxk1";
        };
      }
    ];
    initExtra = ''
      # git stuff
export GIT_EDITOR=nvim

autoload -U promptinit
promptinit
prompt pure

# use c-f for autosuggestions
bindkey '^f' autosuggest-accept
    '';
  };
  programs.foot = {
    enable = true;
    # do not write anything to foot.ini since I already hove 
    # a configuration there. Why the need to reinvent everything?
  };
  programs.tmux = {
    enable = true;
    escapeTime = 200;
# this makes tmux spit out a help message.
#    keyMode = "vi";
    prefix = "m-b";
    sensibleOnTop = false;
    mouse = true;
    clock24 = true; # use 24-h clock.
    extraConfig = ''
set -g default-terminal 'tmux-256color'
set-option -sa terminal-features ',foot:RGB'
set -s escape-time 10 # faster command sequences
set -sg repeat-time 600
set -s focus-events on

# use vim keybindings for copy mode nav
set-window-option -g mode-keys vi

# split panes using _ and -
bind _ split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
unbind '"'
unbind %

# easy config realoads
bind r source-file ~/.tmux.conf

# from https://github.com/namtzigla/oh-my-tmux/blob/master/tmux.conf
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R
unbind n
unbind p
bind -r c-h previous-window
bind -r c-l next-window
bind Enter copy-mode
bind -r H resize-pane -L 2
bind -r J resize-pane -D 2
bind -r K resize-pane -U 2
bind -r L resize-pane -R 2

    '';
  };
  services.clipman.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  home = {
    username = "gsus";
    homeDirectory = "/home/gsus";
    # to figure this out, comment this line and see what it expected.
    stateVersion = "22.11";
  };
}

# https://nix-community.github.io/home-manager/options.html
{pkgs, config,  ...}: {
  programs.home-manager.enable = builtins.trace config.home.profileDirectory true;
  fonts.fontconfig.enable = true;
  home.stateVersion = "23.05";
  home.username = "gsus";
  home.homeDirectory = "/home/gsus";
  home.file = {
    "zls-config" = {
      source = ../../../zls/.config/zls.json;
      target = "./.config/zls.json";
    };
    "cursor-theme" = {
      text = ''
        [icon theme]
        Inherits=Breeze_Snow
        '';
        target = "./.icons/default/index.theme";
    };
  };
  home.packages = with pkgs;
  let custom-fonts = stdenv.mkDerivation {
    name = "Custom Fonts";
    src = ../../../fonts;
    phases = [ "installPhase"];
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      find $src -name '*.ttf' -exec mv {} $out/share/fonts/truetype/ \;
      '';

  };
  in [
    (nerdfonts.override {
      fonts = [ "Iosevka" ];
    })
    wl-clipboard
    ripgrep
    distcc
    gh

    custom-fonts
    pavucontrol
    dconf
    gnomeExtensions.just-perfection
    gnomeExtensions.unite
  ];
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.firefox.enable = true;
  home.pointerCursor = {
    package = with pkgs; stdenv.mkDerivation {
    name = "Breeze Snow";
    src = fetchzip {
      url = "https://code.jpope.org/jpope/breeze_cursor_sources/raw/master/breeze-snow-cursor-theme.zip";
      sha256 = "h1XekN082CJl83eBEr38PzNZpYYBmmmxmrZGG5E7K0o=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      ls $src
      install -d $out/share/icons/Breeze_Snow
      cp -rf $src/* $out/share/icons/Breeze_Snow
      '';
  };
    x11.enable = true;
    gtk.enable = true;
    name = "Breeze_Snow";
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
path+=(~/.local/bin)

autoload -U promptinit
promptinit
prompt pure

# use c-f for autosuggestions
bindkey '^f' autosuggest-accept
    '';
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "tmux -2";
        #font = "Rec Mono Duotone:size=10:fontfeatures=ss04,zero,liga=0";
        font = "Cartograph CF:size=8";
        include = "${../../../foot/.config/foot/iceberg}";
      };
    };
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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  imports = [ ./conf ];
}
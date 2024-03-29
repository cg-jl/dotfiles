{ pkgs, lib, ... }: {
  programs = {
    home-manager.enable = true;
    htop.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    firefox.enable = true;
    zsh = { 
      enable = true;
      initExtra = ''
      path+=($HOME/.cargo/bin $HOME/.local/bin)

      # opam
    [[ ! -r /home/gsus/.opam/opam-init/init.zsh ]] || source /home/gsus/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
      '';
    };

    # use vscode for Jakt
    # TODO: configure extensions (tokyo night)
    vscode.enable = true;
    # track time
    watson.enable = true;

    # TODO: make something that breaks when font isn't installed?
    foot = {
      package = pkgs.foot; # override with nixpkgs-unstable
      enable = true;
      settings = {
        main = {
          shell = "tmux -2";
          font = "Rec Mono Nyx:size=12";
          include = "${pkgs.foot.themes}/share/foot/themes/tokyonight-night";
          # include = "${../../../foot/themes/github-dark-high-contrast}";
        };
      };
    };
    tmux = {
      enable = true;
      escapeTime = 200;
      # this makes tmux spit out a help message.
      #    keyMode = "vi";
      prefix = "m-b";
      sensibleOnTop = false;
      plugins = [];
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

    # TODO: use pinned version of neovim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}

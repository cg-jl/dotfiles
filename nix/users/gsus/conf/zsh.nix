{ pkgs, ... }: {
  programs.zsh = {
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    # don't forget to add 
    # environment.pathsToLink = [ "/share/zsh" ]
    # to system configuration to get completion for system packages
    enableCompletion = true;
    autocd = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lh";
      gap = "git add --patch";
      gst = "git status";
      gpf = "git push --force-with-lease";
      gca = "git commit --amend";
      gcan = "git commit --amend --no-edit";
    };
    plugins = [{
      name = "pure";
      src = pkgs.fetchFromGitHub {
        owner = "sindresorhus";
        repo = "pure";
        rev = "2f13dea466466dde1ba844ba5211e7556f4ae2db";
        sha256 = "1n5n8yi5slzhygsl0g5a633m1vsafmja3pyaklnz61l0l16arxk1";
      };
    }];
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
}

{config,pkgs,...}: {
  imports = [ ];

  users.users.gsus = {
    isNormalUser = true;
    description = "Jesús (gsus) Lapastora";
    hashedPassword = "$6$lSH3SDYFP7Kygh7z$5GKQAWYTRD7ZM9aSC044PhLEIRYzk5V/Uxqq1sj68D4MP1aRe9LDjlhCmopi.JsYvPK142TvWYajTvymgAD7n0";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    packages = [ pkgs.zsh ];
  };


  home-manager.users.gsus = {
    imports = [ ./config.nix ];

    home = {
      inherit (config.system) stateVersion;
      username = "gsus";
      homeDirectory = "/home/gsus";
    };
  };
}

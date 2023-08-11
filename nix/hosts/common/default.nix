{config, lib, pkgs, options, ...}: {
  imports = [
    ./pkgs.nix
    ./graphical.nix
  ];

  options.cpu = lib.mkOption {
    type = lib.types.string;
    default = "baseline";
  };

  config = {

    powerManagement.enable = true;


    boot.loader = {
      systemd-boot.enable = builtins.trace "systemd-boot.enable queried" true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    users = {
      defaultUserShell = pkgs.bash;
      mutableUsers = true;
      users.root = {
        home = "/root";
        uid = config.ids.uids.root;
        initialHashedPassword = lib.mkForce "$6$EmUv5722kukzf3ae$YDXpWgV5HWOl6bBfmYssBbixyXYNS7W0XKak7lVKwfzWdvUAGf4l4vKt.tn/pqnLGjDKOnST7jV3m7a6OJOFx/";
      };
    };

  # enable non-free packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    # enable nix flakes
    package = pkgs.nixFlakes;

    settings = {
      # max jobs for building in parallel
      max-jobs = "auto";
      # perform builds in a sandboxed environment
      sandbox = true;

      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];

      trusted-users = [ "root" config.users.users.gsus.name or "" ];


      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        "https://cache.iog.io"
      ];


      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];


    };
  };

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  console.keyMap = "dvorak";

  networking.networkmanager.enable = true;
  services.openssh.enable = true;
};


}

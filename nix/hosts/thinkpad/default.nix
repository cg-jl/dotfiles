{config, modulesPath, pkgs, ...}: {
  imports = [
    ./hardware.nix
    ../common
    ../../users/gsus
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  nix.settings.build-cores = 16;
  networking.hostName = "jesus-thinkpad";
  system.stateVersion = "22.11";
}

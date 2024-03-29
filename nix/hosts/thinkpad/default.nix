{config, modulesPath, pkgs, lib, ...}: {
  imports = [
    ./hardware.nix
    ../common
  ];

  # nixpkgs.overlays = [
  #   (final: prev: import ./linuxR7.nix { pkgs = prev; inherit lib;})
  # ];
    

  # boot.kernelPackages = pkgs.linuxR7;
  boot.supportedFilesystems = [ "ntfs" ];

  nix.settings.build-cores = 16;
  networking.hostName = "thinkpad";
  system.stateVersion = "23.05";
}

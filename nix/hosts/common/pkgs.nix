{pkgs, ...}: {
  imports = [ ];
  environment.systemPackages = with pkgs; [
    git
    cachix
    home-manager
  ];
}

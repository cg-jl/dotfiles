{pkgs, ...}: {
  # essentials to boot & maintain the system
  environment.systemPackages = with pkgs; [
    git
    cachix 
    home-manager
    efibootmgr
  ];
}

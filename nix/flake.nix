{
  description = "HM dotfiles";
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sanctureplicum-nur.url = "git+https://gitea.pid1.sh/sanctureplicum/nur.git";
    zig.url = "github:mitchellh/zig-overlay";
    zls.url = "github:zigtools/zls";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, home-manager, nur, sanctureplicum-nur, zig, ... }@inputs:
    let
      overlays = final: prev: {
        nur = import nur {
          nurpkgs = prev;
          pkgs = prev;
          repoOverrides = {
            sanctureplicum = import sanctureplicum-nur { pkgs = prev; };
          };
        };
        zigpkgs = zig.packages.${prev.system};
        zls = inputs.zls.packages.${prev.system}.zls;
      };
    in {
      nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, ... }: { config = {  nixpkgs.overlays = [ overlays ]; }; })

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "~";
          }

          ./hosts/thinkpad
        ];
      };
    };
}

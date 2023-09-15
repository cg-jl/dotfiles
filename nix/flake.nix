{
  description = "HM dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # HM required inputs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sanctureplicum.url = "git+https://gitea.pid1.sh/sanctureplicum/nur.git";
    zig.url = "github:mitchellh/zig-overlay";
    zls.url = "github:zigtools/zls";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad
          ./users/gsus

          ({ config, ... }: { config = (import ./hm/overlays.nix).mkConf inputs; })

          # ocaml
          ({pkgs, ...}: { environment.systemPackages = with pkgs; [
            dune_3
          ] ++ (with ocamlPackages; [
            ocaml merlin utop base ppx_jane ocamlformat ocaml-lsp
          ]);})

          home-manager.nixosModules.home-manager (import ./hm)

        ];
      };
    };
}

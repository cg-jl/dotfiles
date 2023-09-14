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
#    rust-overlay.url = "github:oxalica/rust-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { nixpkgs, home-manager, nur, sanctureplicum-nur, zig, nix-doom-emacs,  ... }@inputs:
    let
      overlays = final: prev: {
        nix-doom-emacs = nix-doom-emacs.packages.${prev.system};
        nur = import nur {
          nurpkgs = prev;
          pkgs = prev;
          repoOverrides = {
            sanctureplicum = import sanctureplicum-nur { pkgs = prev; };
          };
        };
        jetbrains = prev.jetbrains // { clion = prev.jetbrains.clion.overrideAttrs (oldAttrs: rec {
          inherit (oldAttrs) nativeBuildInputs buildInputs dontAutoPatchelf postFixup;
          version = "2023.2.1";
          src = prev.fetchurl {
            url = "https://download.jetbrains.com/cpp/CLion-${version}.tar.gz";
            hash = "sha256-Pa1YDy1LQIFcZNpgLjfYdL7wO99QvXDOY++0AFAGzxk=";
          };

        }); };
        zigpkgs = zig.packages.${prev.system};
        zls = inputs.zls.packages.${prev.system}.zls;
      };
    in {
      nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad

          ({ config, ... }: { config = {  nixpkgs.overlays = [ overlays ]; }; })

          # ocaml
          ({pkgs, ...}: { environment.systemPackages = with pkgs; [
            dune_3
          ] ++ (with ocamlPackages; [
            ocaml merlin utop base ppx_jane ocamlformat ocaml-lsp
          ]);})

          home-manager.nixosModules.home-manager (
          {config, lib, ...}:
          {
            options.sourceBuilds.cpu = lib.mkOption {
              type = lib.types.str;
              default = "baseline";
              description = "-Dcpu to use when building Zig software from source.";
            };
            config = {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "~";
              home-manager.extraSpecialArgs = { 
                inherit (config.sourceBuilds) cpu;
              };
            };
          })

        ];
      };
    };
}

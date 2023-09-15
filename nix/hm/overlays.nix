{
  # NOTE: these require copy-pasting. Nix looks at set updates as thunks.
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sanctureplicum.url = "git+https://gitea.pid1.sh/sanctureplicum/nur.git";
    zig.url = "github:mitchellh/zig-overlay";
    zls.url = "github:zigtools/zls";
  };

  mkConf = {nur, sanctureplicum, zig, zls, ...}: { nixpkgs.overlays = [ (final: prev: {
      nur = import nur {
        nurpkgs = prev;
        pkgs = prev;
        repoOverrides = {
          sanctureplicum = import sanctureplicum { pkgs = prev; };
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
      zls = zls.packages.${prev.system}.zls;
    })
    ]; };
}

{pkgs, zigpkgs, cpu, ...}:
let src = pkgs.fetchFromGitHub {
  repo = "poop";
  owner = "andrewrk";
  hash = "sha256-yBMmrZgQjvnuNYecwmHYKlYKKGIjdnbWo8u2ivYYLzU=";
  rev = "281428f88b24e485f2838f743881b99f78fc26b9";
};
  zig = zigpkgs."0.11.0";

in pkgs.stdenvNoCC.mkDerivation {
  name = "poop";
  pname = "poop";
  version = "git+281428";
  nativeBuildInputs = [ zig ];
  inherit src;
  dontInstall = true;
  dontConfigure = true;
  # grabbed from https://github.com/zigtools/zls/blob/master/flake.nix
  buildPhase = ''
    mkdir -p $out
    mkdir -p .cache/{p,z,tmp}
    zig build install --cache-dir $(pwd)/zig-cache --global-cache-dir $(pwd)/.cache -Dcpu=${cpu} -Doptimize=ReleaseSafe --prefix $out
  '';
}

{ pkgs ? import <nixpkgs> { } }:
let
  src = pkgs.fetchFromGitHub {
    owner = "odin-lang";
    repo = "Odin";
    hash = "sha256-udnKEfZFWrasqhU/oPTUm0xjPui3Rj5Bgchf+XWDe3Y=";
    rev = "49b24471133cfbd2664337d99a3259f0b2f4ad45";
  };
  odin-unwrapped = pkgs.llvmPackages_11.stdenv.mkDerivation (rec {
    name = "odin-unwrapped";
    inherit src;
    dontConfigure = true;
    nativeBuildInputs = [ pkgs.git pkgs.which pkgs.llvmPackages_11.llvm ];
    buildPhase = ''
      SHELL=${pkgs.llvmPackages_11.stdenv.shell} ${pkgs.bash}/bin/bash ${src}/build_odin.sh release 
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp odin $out/bin/odin
      cp -r core $out/bin/core
    '';
  });
  path = builtins.map (path: path + "/bin") (with pkgs.llvmPackages_11; [
    bintools
    llvm
    clang
    lld
  ]);
in
pkgs.writeScriptBin "odin" ''
  #!${pkgs.llvmPackages_11.stdenv.shell} 
  PATH="${(builtins.concatStringsSep ":" path)}" exec ${odin-unwrapped}/bin/odin $@
''

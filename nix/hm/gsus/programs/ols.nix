{pkgs, odin, ...}:
let src = pkgs.fetchFromGitHub {
  owner = "DanielGavin";
  repo = "ols";
  rev = "aff00c5060c14cb8b5eed5275a17ebd0e67be7b3";
  hash = "sha256-o3hcsqJlBqatMTeTxfbd+QfjiCnZh871xbgc3G0t4Qk=";
};
in pkgs.stdenv.mkDerivation {
  pname = "ols";
  version = "dev-aff00c50";
  inherit src;
  nativeBuildInputs = [ odin ];
  buildPhase = ''
    mkdir -p $out/bin
    bash build.sh
    mv ols $out/bin/ols
  '';
}

# https://nix-community.github.io/home-manager/options.html
{pkgs, config,  ...}: {
  fonts.fontconfig.enable = true;
  home.stateVersion = "23.05";
  home.username = "gsus";
  home.homeDirectory = "/home/gsus";
  home.file = {
    "zls-config" = {
      source = ../../../zls/.config/zls.json;
      target = "./.config/zls.json";
    };
    "cursor-theme" = {
      text = ''
        [icon theme]
        Inherits=Breeze_Snow
        '';
        target = "./.icons/default/index.theme";
    };
  };
  home.packages = with pkgs;
  let custom-fonts = stdenv.mkDerivation {
    name = "Custom Fonts";
    src = ../../../fonts;
    phases = [ "installPhase"];
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      find $src -name '*.ttf' -exec mv {} $out/share/fonts/truetype/ \;
      '';

  };
  in [
    (nerdfonts.override {
      fonts = [ "Iosevka" ];
    })
    wl-clipboard
    ripgrep
    distcc
    gh

    nixfmt
    custom-fonts
    man-pages
    pavucontrol
    dconf
    gnomeExtensions.just-perfection
    gnomeExtensions.unite
  ];
  home.pointerCursor = {
    package = with pkgs; stdenv.mkDerivation {
    name = "Breeze Snow";
    src = fetchzip {
      url = "https://code.jpope.org/jpope/breeze_cursor_sources/raw/master/breeze-snow-cursor-theme.zip";
      sha256 = "h1XekN082CJl83eBEr38PzNZpYYBmmmxmrZGG5E7K0o=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      ls $src
      install -d $out/share/icons/Breeze_Snow
      cp -rf $src/* $out/share/icons/Breeze_Snow
      '';
  };
    x11.enable = true;
    gtk.enable = true;
    name = "Breeze_Snow";
  };
  # todo: gtk.cursortheme
  imports = [ ./conf ./programs.nix ];
}

# https://nix-community.github.io/home-manager/options.html
{pkgs, config, cpu,  ...}: {
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
    src = ../../../fonts/patched;
    phases = [ "installPhase"];
    installPhase = ''
    mkdir -p $out/share/fonts/truetype
    find $src -name '*.ttf' -exec mv {} $out/share/fonts/truetype/ \;
    '';

  };
  odin = import ./programs/odin.nix { inherit pkgs;};
  ols = import ./programs/ols.nix { inherit pkgs odin; };
  poop = import ./programs/poop.nix { inherit zigpkgs pkgs cpu;  };
  # rust = 
  # rust-bin.selectLatestNightlyWith (toolchain: toolchain.default);
  in [
    nur.repos.sanctureplicum.rec-mono-nyx
    dconf # required for gtk

    telegram-desktop
    jetbrains.clion
    jetbrains.idea-ultimate
    perf-tools
    linuxPackages_latest.perf


    go
    gopls
    nodejs


    man-pages
    binutils # addr2line
    gcc
    clang-tools
    lldb
    meson
    ninja
    odin
    ols
    imv
    poop
    rustup
    cmake
    gdb
    zls
    zigpkgs.master
    (nerdfonts.override {
      fonts = [ "Iosevka" ];
    })
    wl-clipboard
    ripgrep
    distcc
    gh
    jq
    unzip
    file


    libqalculate
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
  gtk = {
    enable = true;
    theme = {
      name = "Catppucin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };
  # todo: gtk.cursortheme
  imports = [ ./conf ./programs.nix ];
}

# Adapted from
# https://gitea.pid1.sh/sanctureplicum/config/src/branch/main/users/carsten/conf/gnome.nix
# NOTE: if making any changes to the config, use the gui and then
# dconf2nix: https://github.com/gvolpe/dconf2nix
{ config, lib, osConfig, ...}: {
  config = lib.mkIf osConfig.graphical {
    xdg.dataFile.backgrounds.source = ../../../../wallpapers;
    dconf.settings = {
      # xdg.dataFile.backgrounds.source = ../wallpapers;
      # TODO: wallpapers
      # TODO: use file://${config.xdg.dataHome} for backgrounds
      "org/gnome/desktop/interface".enable-hot-corners = false;
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ] ;
        enabled-extensions = [ 
          "just-perfection-desktop@just-perfections"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "unite@hardpixel.eu"
        ];
        favorite-apps = [ "org.codeberg.dnkl.foot.desktop" "firefox.desktop" ];
      };
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file://${config.xdg.dataHome}/backgrounds/asturias.jpg";
      };
      "org/gnome/shell/extensions/unite".hide-window-titlebars = "always";
      "org/gnome/shell/extensions/just-perfection" = {
        panel = false;
        panel-in-overview = true;
      };
      "org/gnome/shell/extensions/user-theme".name = "Catppuccin-Mocha";
      "org/gnome/desktop/interface-gtk/theme".name = "Catppuccin-Mocha";
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>w"];
      };
  };
  };
}

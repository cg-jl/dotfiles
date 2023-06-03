{ config, lib, pkgs, ...}: {
  options.graphical = lib.mkOption {
    default = true;
    type = lib.types.bool;
    description = "Whether this target contains a graphical UI";
  };

  config = lib.mkIf config.graphical {
    # Audio
    # TODO: consider NoiseTorch
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pipewire
    ];

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "dvorak-alt-intl";

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    services.printing.enable = true;
  };
}

{config, lib, options, ...}: {
  options.sourceBuilds.cpu = lib.mkOption {
    type = lib.types.str;
    default = "baseline";
    description = "-Dcpu to use when building Zig software from source";
  };
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.extraSpecialArgs = { cpu = config.sourceBuilds.cpu; };

    home-manager.users.gsus = {
      imports = [ ./gsus ];
      programs.zsh.enable = true;
    };
  };
}

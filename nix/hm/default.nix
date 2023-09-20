isNixOS: {config, lib, options, ...}:
{
  options.sourceBuilds.cpu = lib.mkOption {
    type = lib.types.str;
    default = "baseline";
    description = "-Dcpu to use when building Zig software from source";
  };
} // (if isNixOS then {
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.extraSpecialArgs = { cpu = config.sourceBuilds.cpu; };

    home-manager.users.gsus = {
      imports = [ ./gsus ];
      programs.zsh.enable = true;
    };
  };
} else {
    imports = [  
      { _module.args.cpu = config.sourceBuilds.cpu; }
      ./gsus
    ];
})

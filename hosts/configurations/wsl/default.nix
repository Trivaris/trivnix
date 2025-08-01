{
  inputs,
  libExtra,
  hostconfig,
  ...
}:
{

  imports = [
    (libExtra.mkFlakePath /hosts/common)
    (libExtra.mkFlakePath /hosts/modules)
  ] ++ [
    ./hardware.nix
    inputs.nixos-wsl.nixosModules.default
  ];

  config = {
    nixosConfig = hostconfig.nixosConfig;

    wsl = {
      enable = true;
      defaultUser = builtins.head hostconfig.users;
      wslConf.network.hostname = hostconfig.name;
    };
  };
  
}
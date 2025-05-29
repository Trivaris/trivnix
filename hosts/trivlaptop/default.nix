{
  config,
  inputs,
  ...
}: {

  imports = [ 
    ../common
    ./disko-config.nix
    ./hardware-configuration.nix
    ./configuration.nix
    ./keymap.nix
    ./system-packages.nix
  ];

  colorTheme = ../common/themes/material-green.nix;
  
}
{
  lib,
  config,
  inputs,
  ...
}: with lib; {

  options.colorTheme = mkOption {
    type = types.attrs;
    description = "Color theme definition used across the system.";
    default = import ../common/themes/material-green.nix;
  };

}
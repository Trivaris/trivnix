{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.userPrefs;
in
{
  options.userPrefs.email.enable = mkEnableOption "Enable Email Accounts";

  config = mkIf cfg.email.enable {

  };
}
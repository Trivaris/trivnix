{
  config,
  lib,
  userInfos,
  ...
}:
let
  inherit (lib) mkIf;
  prefs = config.userPrefs;
in
{
  config = mkIf (builtins.elem "thunderbird" prefs.desktopApps) {
    programs.thunderbird = {
      enable = true;
      profiles.${userInfos.name} = {
        isDefault = true;
      };
    };
  };
}

{ pkgs, lib, config, inputs, userconfig, hostconfig, ... }:
let
  cfg = config.homeConfig;
  prefs = builtins.readFile (inputs.betterfox + "/user.js") + ''
    /** OVERRIDES ***/
    user_pref("browser.ctrlTab.sortByRecentlyUsed", true);
    user_pref("places.history.enabled", false);
  '';
in
with lib;
{
  options.homeConfig.librewolf = import ./config.nix lib;

  config = mkIf (builtins.elem "librewolf" cfg.desktopApps) {
    programs.librewolf = {
      enable = true;

      profiles.${userconfig.name} = {
        isDefault = true;

        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            adnauseam
            tab-session-manager
            bitwarden
            plasma-integration
          ];
        };
        
        search = {
          default = "brave";
          order = [ "brave" ];
          engines = {
            brave = {
              name = "Brave";
              urls = [{
                template = "https://search.brave.com/search";
                params = [{ name = "q"; value = "{searchTerms}"; }];
              }];
            };
          };
        };
      };

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        SanitizeOnShutdown = mkIf (cfg.librewolf.clearOnShutdown) true;
        ClearOnShutdown = mkIf (cfg.librewolf.clearOnShutdown) {
          cache = true;
          cookies = true;
          downloads = true;
          formdata = true;
          history = true;
          passwords = false;
          sessions = true;
          siteSettings = false;
          offlineApps = true;
        };

        Cookies.Allow = cfg.librewolf.allowedCookies;
      };
    };

    stylix.targets.librewolf.profileNames = [ userconfig.name ];

    home.file.".librewolf/${userconfig.name}/user.js".source = mkIf (cfg.librewolf.betterwolf) (inputs.betterfox + "/user.js");
  };
}

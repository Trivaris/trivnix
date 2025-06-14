{ pkgs, config, lib, ... }:
let
  cfg = config.modules;
in
with lib;
{

  options.modules.cli-utils = mkEnableOption "cli tools";

  config = mkIf cfg.cli-utils {

    home.packages = with pkgs; [
      procs
      btop
      fastfetch
      pipes-rs
      rsclock
    ];

    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      extraOptions = [
        "-l"
        "--icons"
        "--git"
        "-a"
      ];
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

  };

}

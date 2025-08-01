{
  config,
  pkgs,
  lib,
  userconfig,
  ...
}:
let
  cfg = config.homeConfig;
in
with lib;
{
  options.homeConfig.fish.enable = mkEnableOption "extended fish configuration";

  config = mkIf cfg.fish.enable {
    programs.fish = {
      enable = true;

      loginShellInit = ''
        set -x NIX_LOG info
        ${if (builtins.elem "alacritty" cfg.desktopApps) then "set -x TERMINAL alacritty" else ""}
      '';

      interactiveShellInit = ''
        set fish_greeting
        starship init fish | source
        zoxide init fish | source
        fastfetch
      '';

      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../../";

        "gstat" = "git status --short";
        "gadd" = "git add";
        "gcomm" = "git commit -m ";
        "gpull" = "git pull";
        "gpush" = "git push";
        "gclone" = "git clone";
      };

      functions = {
        cd.body = "z \"$argv\"";
        grep.body = "rg \"$argv\"";
        ls.body = "eza \"$argv\"";

        fix-endings = ''
          mv ./.git ../
          find . -type f -exec sed -i 's/\r$//' {} +
          mv ../.git ./
        '';

        rm-clobbering = ''
          rm -f ~/.gtkrc-2.0.backup
          rm -f ~/.librewolf/${userconfig.name}/search.json.mozlz4.backup
          sudo rm -f ~/.config/gtk-3.0/gtk.css.backup
        '';
      };
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[❯](green)";
          error_symbol = "[❯](red)";
        };
        directory = {
          style = "blue";
        };
      };
    };

    programs.tmux.shell = "${pkgs.fish}/bin/fish";

    programs.eza.enableFishIntegration = true;
    programs.zoxide.enableFishIntegration = true;
    programs.fzf.enableFishIntegration = true;
  };
}

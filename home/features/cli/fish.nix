{
  config,
  lib,
  flakePath,
  ...
}:
with lib; let
  cfg = config.features.cli.fish;
in {

  options.features.cli.fish.enable = mkEnableOption "extended fish configuration";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      loginShellInit = ''
        set -x NIX_PATH nixpkgs=channel:nixos-unstable
        set -x NIX_LOG info
        set -x TERMINAL ghostty

        start-hyprland
      '';
      interactiveShellInit = ''
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

        "ls" = "eza";
        "grep" = "rg";
      };

      functions.cd.body = "z $argv";
      functions.start-hyprland = ''
        if test (tty) = "/dev/tty1"
          exec Hyprland &> /dev/null
        end
      '';
      functions.nix-rebuild = ''
        set flakePath ${flakePath}
        set currentPath (pwd)

        set endColor "\e[0m"

        echo "\e[32mUpdating and rebuilding from flake: $flakePath$endColor"
        begin
          cd $flakePath
          echo "\e[32mPulling Git Changes $endColor"
          sudo git pull
          echo "\e[32mUpdating dotfiles $endColor"
          nix flake lock --update-input dotfiles
          echo "\e[32mRebuilding$endColor"
          sudo nixos-rebuild switch --flake $flakePath#trivlaptop
          echo "\e[32mNavigating to original path: $currentPath$endColor"
          cd $currentPath
        end
      '';
    };
  };

}
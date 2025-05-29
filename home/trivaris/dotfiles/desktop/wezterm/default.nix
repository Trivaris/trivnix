{ config, lib, pkgs, ... }:

let
  theme = config.colorTheme.colors.dark;

  weztermColorScheme = {
    name = "Material Green";
    foreground = theme.on_surface;
    background = theme.background;
    cursor_bg = theme.primary;
    cursor_border = theme.primary;
    cursor_fg = theme.on_primary;
    selection_bg = theme.surface_container_high;
    selection_fg = theme.on_surface;
    ansi = [
      theme.surface_dim
      theme.error
      theme.primary
      theme.tertiary
      theme.tertiary
      theme.secondary
      theme.tertiary_fixed_dim
      theme.on_surface_variant
    ];
    brights = [
      theme.surface_bright
      theme.error_container
      theme.primary_fixed_dim
      theme.tertiary_fixed_dim
      theme.on_tertiary
      theme.secondary_fixed_dim
      theme.on_secondary
      theme.surface_container_highest
    ];
  };
in {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    extraConfig = ''
      return {
        color_scheme_dirs = { "/etc/wezterm/colors" },
        color_scheme = "Material Green",
      }
    '';
  };

  environment.etc."wezterm/colors/material-green.toml".text =
    pkgs.lib.generators.toTOML {} weztermColorScheme;
}

{
  inputs,
  pkgs,
  ...
}: {

  services.hyprpaper = {
    enable = true;
    settings = {
      interval = 600;
      splash = false;
      preload = [
        "${inputs.self}/resources/wp_1.png"
        "${inputs.self}/resources/wp_2.png"
        "${inputs.self}/resources/wp_3.png"
      ];
      wallpaper = [
        "eDP-1,${inputs.self}/resources/wp_1.png"
        "DP-1,${inputs.self}/resources/wp_1.png"
      ];
    };
  };

}
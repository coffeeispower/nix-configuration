{pkgs, config, ...}: {
  wayland.windowManager.hyprland.settings.exec = [
    "${pkgs.hyprpaper}/bin/hyprpaper -c ${
      pkgs.writeText "hyprpaper.conf" ''
        preload=${config.stylix.image}
        wallpaper=eDP-1,${config.stylix.image}
        wallpaper=DP-1,${config.stylix.image}
      ''
    }"
  ];
}
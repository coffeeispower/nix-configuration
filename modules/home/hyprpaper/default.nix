{pkgs, ...}: {
  wayland.windowManager.hyprland.settings.exec = [
    "${pkgs.hyprpaper}/bin/hyprpaper -c ${
      pkgs.writeText "hyprpaper.conf" ''
        preload=${./wallpapers/hackerman.jpg}
        wallpaper=eDP-1,${./wallpapers/hackerman.jpg}
      ''
    }"
  ];
}
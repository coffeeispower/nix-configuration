{pkgs, config, ...}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=${config.stylix.image}
    wallpaper=eDP-1,${config.stylix.image}
    wallpaper=DP-1,${config.stylix.image}
  '';
  wayland.windowManager.hyprland.settings.exec = [
    "${pkgs.hyprpaper}/bin/hyprpaper"
  ];
}

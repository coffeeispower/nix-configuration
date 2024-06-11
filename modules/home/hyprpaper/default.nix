{
  config,
  ...
}:
{
  services.hyprpaper.settings = {
    preload = ["${config.stylix.image}"];
    wallpaper = [",${config.stylix.image}"];
  };
}

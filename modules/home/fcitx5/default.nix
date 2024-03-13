{
  lib,
  config,
  ...
}:
with lib; {
  options.services.fcitx5.enable = mkEnableOption "fcitx5";
  config.home.file.".config/fcitx5/" = {
    enable = config.services.fcitx5.enable;
    source = ./fcitx5;
    recursive = false;
  };
}

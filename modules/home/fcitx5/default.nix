{
  lib,
  config,
  ...
}:
with lib; {
  options.services.fcitx5.enable = mkEnableOption "fcitx5";
}

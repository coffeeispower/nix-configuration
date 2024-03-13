{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  options.programs.networkmanager-dmenu.enable = lib.mkEnableOption "networkmanager-dmenu-config";
  config.home.packages = [
    (lib.mkIf config.programs.networkmanager-dmenu.enable pkgs.networkmanager_dmenu)
    (lib.mkIf config.programs.networkmanager-dmenu.enable pkgs.networkmanagerapplet)
  ];
  config.home.file.".config/networkmanager-dmenu/config.ini" = {
    enable = config.programs.networkmanager-dmenu.enable;
    source = lib.my-lib.mustache.template {
      inherit pkgs;
      templateFile = ./config.ini;
      name = "networkmanager-dmenu-config";
      variables = {
        colors = config.stylix.base16Scheme;
        commands = {
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
          terminal = "${pkgs.kitty}/bin/kitty";
        };
      };
    };
  };
}

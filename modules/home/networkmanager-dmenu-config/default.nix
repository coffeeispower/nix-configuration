{lib, config, inputs, pkgs, ...}:
{
  home.file.".config/networkmanager-dmenu/config.ini" = {
    source = lib.my-lib.mustache.template {
      inherit pkgs;
      templateFile = ./config.ini;
      name = "networkmanager-dmenu-config";
      variables = {
        colors = config.stylix.base16Scheme;
        commands = {
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
          terminal = "${pkgs.alacritty}/bin/alacritty";
        };
      };
    };
  };
}
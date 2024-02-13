{ lib, config, pkgs, inputs, ... }:
{
  home.file.".config/eww" = {
    source = pkgs.stdenv.mkDerivation {
      src = ./.;
      name = "eww-config";
      installPhase = ''
        mkdir -p $out
        cp ${
          lib.my-lib.mustache.template {
            inherit pkgs;
            name = "eww-config-scss";
            templateFile = ./eww.template.scss;
            variables = config.colorScheme.palette;
          }
        } $out/eww.scss
        cp *.yuck $out/
      '';
    };
    recursive = true;
  };
  wayland.windowManager.hyprland.settings.exec = [
    (pkgs.writeShellScript "reset-eww" ''
          eww close-all
          eww open bar
        '')
    ];
}
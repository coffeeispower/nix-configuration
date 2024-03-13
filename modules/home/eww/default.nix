{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  xdg.configFile."eww" = lib.mkIf config.programs.eww.enable {recursive = true;};
  home.packages = [
    (lib.mkIf config.programs.eww.enable pkgs.playerctl)
  ];
  programs.eww.package = pkgs.eww-wayland;
  programs.eww.configDir = pkgs.stdenv.mkDerivation {
    src = ./.;
    name = "eww-config";
    installPhase = ''
      mkdir -p $out
      cp ${
        lib.my-lib.mustache.template {
          inherit pkgs;
          name = "eww-config-scss";
          templateFile = ./eww.template.scss;
          variables =
            config.stylix.base16Scheme
            // {
              desktopOpacity = builtins.toString config.stylix.opacity.desktop;
            };
        }
      } $out/eww.scss
      cp *.yuck $out/
    '';
  };
}

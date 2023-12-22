{ pkgs, lib, widgets-bg, widgets-fg, widgets-fg-light, widgets-track, low-battery-color, charging-battery-color }:
pkgs.stdenv.mkDerivation {
  name = "eww-config";
  src = ./eww-config;
  buildPhase = ''
        echo '$widgets-bg: ${widgets-bg};
    $widgets-fg: ${widgets-fg};
    $widgets-fg-light: ${widgets-fg-light};
    $widgets-track: ${widgets-track};
    $low-battery-color: ${low-battery-color};
    $charging-battery-color: ${charging-battery-color};' > variables.scss;
        cat variables.scss eww-template.scss > eww.scss
  '';
  installPhase = ''
    mkdir -p $out
    cp eww.scss eww.yuck $out/
  '';
}

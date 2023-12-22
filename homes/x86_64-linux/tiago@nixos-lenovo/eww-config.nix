{
  pkgs, lib,
  widgets-bg,
  widgets-fg,
  widgets-fg-light,
  widgets-track
}:
pkgs.stdenv.mkDerivation {
  name = "eww-config";
  src = ./eww-config;
  buildPhase = ''
    echo '$widgets-bg: ${widgets-bg};
$widgets-fg: ${widgets-fg};
$widgets-fg-light: ${widgets-fg-light};
$widgets-track: ${widgets-track};' > variables.scss;
    cat variables.scss eww-template.scss > eww.scss
  '';
  installPhase = ''
    mkdir -p $out
    cp eww.scss eww.yuck $out/
  '';
}
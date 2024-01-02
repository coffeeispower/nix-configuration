{ pkgs, config }:
let
  template = (import ./mustache.nix) pkgs;
in
pkgs.stdenv.mkDerivation {
  name = "eww-config";
  src = ./eww-config;
  installPhase = ''
    mkdir -p $out
    cp ${template "eww-config" ./eww-config/eww.template.scss config.colorScheme.colors} $out/eww.scss
    cp eww.yuck $out/eww.yuck
  '';
}

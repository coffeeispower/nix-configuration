{lib, pkgs, config, inputs, ...}: 
with config.stylix.base16Scheme;
let
  inherit (inputs.nix-rice.lib) color;

  bgRgba = color.hexToRgba "#${base00}";
  bgDarkRgba = color.darken 30 bgRgba;
  bgDarkerRgba = color.darken 30 bgDarkRgba;
  
  bg = color.toRGBHex bgRgba;
  bgDark = color.toRGBHex bgDarkRgba;
  bgDarker = color.toRGBHex bgDarkerRgba;
  
  base03Rgba = color.hexToRgba "#${base03}";
  base0DRgba = color.hexToRgba "#${base0D}";

  stylixTheme = lib.my-lib.mustache.template {
    inherit pkgs;
    name = "vesktop-stylix-theme";
    templateFile = ./themes/Stylix.theme.css;
    variables = {
      inherit bg bgDark bgDarker;
      accent = "${builtins.toString (builtins.floor base03Rgba.r)}, ${builtins.toString (builtins.floor base03Rgba.g)}, ${builtins.toString (builtins.floor base03Rgba.b)}";
      accentAlt = "${builtins.toString (builtins.floor base0DRgba.r)}, ${builtins.toString (builtins.floor base0DRgba.g)}, ${builtins.toString (builtins.floor base0DRgba.b)}";
    };
  };
  settingsJson = lib.my-lib.mustache.template {
    inherit pkgs;
    name = "vesktop-settings-json";
    templateFile = ./settings.json;
    variables = config.stylix.base16Scheme;
  };
  settingsSettingsJson = lib.my-lib.mustache.template {
    inherit pkgs;
    name = "vesktop-settings-settings-json";
    templateFile = ./settings/settings.json;
    variables = config.stylix.base16Scheme;
  };
in
{

  home.packages = [ pkgs.vesktop ];
  xdg.configFile."VencordDesktop/VencordDesktop/" = {
    recursive = true;
    source = pkgs.stdenv.mkDerivation {
      src = ./.;
      name = "vesktop-config";
      installPhase = ''
        mkdir -p $out/{settings,themes}
        cp ${stylixTheme} $out/themes/Stylix.theme.css
        cp ${settingsJson} $out/settings.json
        cp ${settingsSettingsJson} $out/settings/settings.json
      '';
    };
  };
}

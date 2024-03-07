{lib, pkgs, config, inputs, system, ...}: 
with config.stylix.base16Scheme;
let
  inherit (inputs.nix-rice.lib) color;

  bgRgba = color.hexToRgba "#${base00}";
  bgDarkRgba = color.darken 5 bgRgba;
  bgDarkerRgba = color.darken 5 bgDarkRgba;
  
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

  home.packages = [ (import inputs.nixpkgs-unstable { inherit system; }).vesktop ];
  home.activation.vencordCP = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.config/VencordDesktop/VencordDesktop/settings/
    rm -f $HOME/.config/VencordDesktop/VencordDesktop/settings.json $HOME/.config/VencordDesktop/VencordDesktop/settings/settings.json
    cat ${settingsJson} > $HOME/.config/VencordDesktop/VencordDesktop/settings.json
    cat ${settingsSettingsJson} > $HOME/.config/VencordDesktop/VencordDesktop/settings/settings.json
  '';
  xdg.configFile."VencordDesktop/VencordDesktop/themes/Stylix.theme.css".source = stylixTheme;  
}

{lib, pkgs, config, inputs, system, ...}: 
with config.stylix.base16Scheme;
let
  inherit (inputs.nix-rice.lib) color;

  base03Rgba = color.hexToRgba "#${base03}";
  base0DRgba = color.hexToRgba "#${base0D}";
  dmWhite = color.hexToRgba "#${base05}";
  stylixTheme = lib.my-lib.mustache.template {
    inherit pkgs;
    name = "vesktop-stylix-theme";
    templateFile = ./themes/Stylix.theme.css;
    variables = {
      accent = "${builtins.toString (builtins.floor base03Rgba.r)}, ${builtins.toString (builtins.floor base03Rgba.g)}, ${builtins.toString (builtins.floor base03Rgba.b)}";
      accentAlt = "${builtins.toString (builtins.floor base0DRgba.r)}, ${builtins.toString (builtins.floor base0DRgba.g)}, ${builtins.toString (builtins.floor base0DRgba.b)}";
      dmWhite = "${builtins.toString (builtins.floor dmWhite.r)}, ${builtins.toString (builtins.floor dmWhite.g)}, ${builtins.toString (builtins.floor dmWhite.b)}";
    } // config.stylix.base16Scheme;
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
    mkdir -p $HOME/.config/vesktop/settings/
    cat ${settingsJson} > $HOME/.config/vesktop/settings.json
    cat ${settingsSettingsJson} > $HOME/.config/vesktop/settings/settings.json
  '';
  xdg.configFile."vesktop/themes/Stylix.theme.css".source = stylixTheme;  
}

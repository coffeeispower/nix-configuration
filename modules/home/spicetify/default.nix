{config, inputs, pkgs, ...}:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
with config.stylix.base16Scheme;
{
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      trashbin
      loopyLoop
      keyboardShortcut
    ];
    colorScheme = "custom";
    customColorScheme = {
      main = base00;
      button = base09;
      
      sidebar = base0D;
      selected-row = base03;
      
      text = base0D;
      subtext = base0D;
      tab-active = base03;

      
      sidebar-text = base0D;
      
      player = base0E;
      
      card = base01;
      button-active = base0E;
      button-disabled = base0D;
      
      notification = base09;
      notification-error = base08;

      misc = base00;

      shadow = "000000";
    };
  };
}

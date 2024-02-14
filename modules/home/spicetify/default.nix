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
      button = base09;
      main = base00;
      subtext = base01;
      text = base04;
      sidebar = base01;
      selected-row = base03;
      tab-active = base03;
      sidebar-text = base00;
      player = base04;
      card = base06;
      shadow = "000000";
      button-active = base0E;
      button-disabled = base0D;
      notification = base04;
      notification-error = base04;
      misc = base04;
    };
  };
}

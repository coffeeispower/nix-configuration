{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
  with config.stylix.base16Scheme; {
    imports = [inputs.spicetify-nix.homeManagerModules.default];
    programs.spicetify = {
      theme = {
        name = "Comfy";
        src = inputs.comfy-theme-spicetify;
        injectCss = true;
        replaceColors = true;
        overwriteAssets = true;
        sidebarConfig = true;
      };
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        trashbin
        loopyLoop
        keyboardShortcut
        brokenAdblock
        {
          filename = "spicetify-furigana-lyrics.js";
          src = "${inputs.spicetify-furigana-lyrics}/dist";
        }
      ];
      colorScheme = "custom";
      customColorScheme = {
        subtext = base0F;
        text = base05;
        main = base00;
        main-transition = base01;
        main-elevated = base02;
        highlight = base03;
        highlight-elevated = base04;
        sidebar = base00;
        player = base00;
        card = base00;
        shadow = base02;
        selected-row = base0C;
        button = base0E;
        button-active = base0D;
        button-disabled = base01;
        tab-active = base01;
        notification = base0E;
        notification-error = base08;
        misc = base0E;
        play-button = base0D;
        play-button-active = base0E;
        progress-fg = base0E;
        progress-bg = base01;
        heart = base08;
        pagelink-active = base0D;
        radio-btn-active = base02;
      };
    };
  }

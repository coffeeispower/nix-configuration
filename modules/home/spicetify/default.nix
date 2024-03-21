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
        text               = base04;
        subtext            = base05;

        main               = base00;
        main-elevated      = base02;
        main-transition    = base01;

        highlight          = base01;
        highlight-elevated = base01;
        
        sidebar            = base00;
        player             = base00;
        card               = base01;
        shadow             = "1E2233";

        selected-row       = base01;

        button             = base01;
        button-active      = base02;
        button-disabled    = base09;
        
        tab-active         = base0D;
        notification       = base06;
        notification-error = base0F;
        misc               = "000000";

        play-button        = base02;
        play-button-active = base0D;
        
        progress-fg        = base0D;
        progress-bg        = base01;

        heart              = base0D;

        pagelink-active    = base0E;
        radio-btn-active   = base02;
      };
    };
  }

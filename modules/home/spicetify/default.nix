{
  config,
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
  {
    imports = [inputs.spicetify-nix.homeManagerModules.default];
    programs.spicetify = {
      theme = {
        injectCss = true;
        replaceColors = true;
        overwriteAssets = true;
      };
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        trashbin
        loopyLoop
        keyboardShortcut
        adblock
        {
          name = "spicetify-furigana-lyrics.js";
          src = "${inputs.spicetify-furigana-lyrics}/dist";
        }
      ];
    };
  }

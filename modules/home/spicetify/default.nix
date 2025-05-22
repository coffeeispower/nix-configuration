{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
  with config.lib.stylix.colors; {
    imports = [inputs.spicetify-nix.homeManagerModules.default];
    programs.spicetify = {
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

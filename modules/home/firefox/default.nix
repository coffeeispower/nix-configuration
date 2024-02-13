{inputs, system, ...}: {
  programs.firefox = {
    enable = true;
    profiles.tiago = {
      settings = {
        "browser.tabs.inTitlebar" = "0";
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.translations.neverTranslateLanguages" = "en";
        "browser.translations.panelShown" = false;
      };
      extensions = let
        firefox-ext = inputs.firefox-addons.packages.${system};
      in [
        firefox-ext.ublock-origin
        firefox-ext.darkreader
        firefox-ext."10ten-ja-reader"
        firefox-ext.proton-pass
      ];
    };
  };
}
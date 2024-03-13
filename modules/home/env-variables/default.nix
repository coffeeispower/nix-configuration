{pkgs, ...}: {
  home.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
    TERMINAL = "${pkgs.kitty}/bin/kitty";
  };
}
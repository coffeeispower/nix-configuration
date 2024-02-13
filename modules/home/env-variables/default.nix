{pkgs, ...}: {
  home.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
    TERMINAL = "${pkgs.alacritty}/bin/alacritty";
  };
}
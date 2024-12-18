{...}: {
  home.stateVersion = "24.05";
  services.gpg-agent.enable = true;
  services.fcitx5.enable = false;
  services.dunst.enable = true;
  services.hyprpaper.enable = true;
  services.hypridle.enable = true;
  gtk.enable = true;
  programs.direnv.enable = true;
  programs.hyprlock.enable = true;
  programs.eww.enable = true;
  programs.feh.enable = true;
  programs.feh.mimeApps.defaultAssociation.enable = true;
  programs.firefox.enable = true;
  programs.gh.enable = true;
  programs.helix.enable = true;
  programs.kitty.enable = true;
  programs.lazygit.enable = true;
  programs.networkmanager-dmenu.enable = true;
  programs.nushell.enable = true;
  programs.rofi.enable = true;
  programs.spicetify.enable = false;
  programs.nautilus.enable = true;
  programs.vscode.enable = false;
  programs.zellij.enable = false;
  programs.zoxide.enable = false;
  wayland.windowManager.hyprland.enable = true;
}

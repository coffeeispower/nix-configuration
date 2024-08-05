{pkgs, ...}: {
  home.stateVersion = "24.05";
  programs.git = {
    enable = true;
    userName = "Tiago Dinis";
    userEmail = "tiagodinis33@proton.me";
  };

  services.gpg-agent.enable = true;
  programs.gh.enable = true;
  programs.helix.enable = true;
  programs.lazygit.enable = true;
  programs.networkmanager-dmenu.enable = false;
  programs.nushell.enable = true;
  programs.zellij.enable = true;
  programs.zoxide.enable = true;
  programs.fastfetch.enable = true;
  programs.direnv.enable = true;
}

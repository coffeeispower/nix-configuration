{pkgs, modulesPath, ...}: {
  imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];
  
  # This conflicts with networkmanager
  networking.wireless.enable = false;
  users.users.nixos.shell = pkgs.nushell;
  security.doas.extraRules = [
    {
      users = ["nixos"];
      keepEnv = true; # Optional, retains environment variables while running commands
      persist = true; # Optional, only require password verification a single time
    }
  ];
  services.xserver.displayManager.sddm.settings.Autologin = {
    Session = "hyprland.desktop";
    User = "nixos";
  };
  nixpkgs.hostPlatform = "x86_64-linux";
}
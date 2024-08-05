{
  config,
  pkgs,
  lib,
  system,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    /tmp/hardware-configuration.nix
  ];
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["tiago"];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
  users.users.tiago = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "adbusers" "networkmanager"]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$x4wYgVWjLlUp43gVSTvj61$XX50fudyvMCLx0kvm/EHAplZ.ev1Lxj1ZrRoB4itEMA";
    shell = pkgs.nushell;
  };

  security.doas.extraRules = [
    {
      users = ["tiago"];
      keepEnv = true; # Optional, retains environment variables while running commands
      persist = true; # Optional, only require password verification a single time
    }
  ];
  boot.resumeDevice = (builtins.elemAt config.swapDevices 0).device;
  environment.systemPackages = with pkgs; [

    # For virt manager
    virtiofsd

    # Some development tools I use

    ## Nix language server
    nil


    ## C compilers
    clang

    ## C LSP
    clang-tools

    ## Nix formatter
    alejandra

    ## redis-cli
    redis

    ## Generate compile-commands.json
    bear

    ## Code lines counter
    scc

    # For samba
    cifs-utils
    # For controlling CPU power
    glib
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # services.xserver.displayManager.sddm.settings.Autologin = {
  #   Session = "hyprland.desktop";
  #   User = "tiago";
  # };


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  boot.kernelParams = ["quiet" "splash"];
  boot.consoleLogLevel = 0;
    networking.firewall = {
    enable = true;
    allowedTCPPorts = [25565 5001 22];
    allowedUDPPortRanges = [];
  };
}

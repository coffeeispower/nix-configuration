# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  # Enable plymouth
  boot.kernelParams = ["quiet" "splash"];
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  # Enable GVFS to be able to mount and see removable devices in thunar
  services.gvfs.enable = true;
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Set hostname
  networking.hostName = "nixos-lenovo";
  networking.networkmanager.enable = true;
  # Add soem fonts
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig = { defaultFonts.monospace = [ "FiraCode" ]; };
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      ipafont
    ];
  };
  # Set your time zone.
  time.timeZone = "Europe/Lisbon";
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_PT.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #    keyMap = lib.mkForce "pt";
    useXkbConfig = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.xserver.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.dconf.enable = true;
  programs.git.enable = true;
  programs.hyprland.enable = true;
  users.users.tiago = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    hashedPassword =
      "$y$j9T$x4wYgVWjLlUp43gVSTvj61$XX50fudyvMCLx0kvm/EHAplZ.ev1Lxj1ZrRoB4itEMA";
    shell = pkgs.nushell;
  };
  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    btop
    gnome.gnome-disk-utility
    gnome.file-roller
    pinentry-rofi
    plymouth
  ];
  system.stateVersion = "unstable";
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  xdg.portal.config = { common = { default = [ "hyprland" ]; }; };
  xdg.portal.enable = true;

  # Enable noise torch
  programs.noisetorch.enable = true;
  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  # Enable japanese input with ibus
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-mozc ];
  };
  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  programs.gnupg.agent = {
    enable = true;
    settings = {
      pinentry-program = lib.mkForce "${pkgs.pinentry-rofi}/bin/pinentry-rofi";
    };
    enableSSHSupport = true;
  };
}

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos-lenovo";
  networking.networkmanager.enable = true;
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
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPassword =
      "$y$j9T$x4wYgVWjLlUp43gVSTvj61$XX50fudyvMCLx0kvm/EHAplZ.ev1Lxj1ZrRoB4itEMA";
    shell = pkgs.nushell;
  };
  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
  ];
  #  programs.gnupg.agent = {
  #    enable = true;
  #    enableSSHSupport = true;
  #  };
  #
  system.stateVersion = "unstable";
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  xdg.portal.config = { common = { default = [ "hyprland" ]; }; };
  xdg.portal.enable = true;

  # Enable noise torch
  programs.noisetorch.enable = true;
}


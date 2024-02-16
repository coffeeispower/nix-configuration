{ config, pkgs, lib, system, inputs, ... }: {
  
  # Enable plymouth
  boot.plymouth.enable = true;
  # Enable GVFS to be able to mount and see removable devices in thunar
  services.gvfs.enable = true;
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  boot.kernelParams = [ "quiet" "splash" ];
  boot.initrd.systemd.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  
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
    # keyMap = lib.mkForce "pt";
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
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  programs.dconf.enable = true;
  programs.git.enable = true;
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    my-lib.slides
    virtiofsd
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    btop
    gnome.gnome-disk-utility
    gnome.file-roller
    pinentry-rofi
    plymouth
    cifs-utils
    inputs.nix-software-center.packages.${system}.nix-software-center
    inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    networkmanagerapplet
    protonvpn-gui
    eww-wayland
    libreoffice
    evince
    lutris
    wine
    nixfmt
    pamixer
    libnotify
    spotify
    vesktop
    cli-visualizer
    pavucontrol
    neofetch
    feh
    vlc
    networkmanager_dmenu
    playerctl
    prismlauncher
    clang
    wdisplays
    beekeeper-studio
    ferdium
    obsidian
    gimp
    transmission-gtk
  ];
  environment.shells = [ pkgs.nushell ];
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  xdg.portal.config = { common = { default = [ "hyprland" ]; }; };
  xdg.portal.enable = true;

  # Enable noise torch
  programs.noisetorch.enable = true;
  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };
  # Enable japanese input with ibus
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-mozc ];
  };
  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  programs.gnupg.agent = {
    enable = true;
    settings = {
      pinentry-program = lib.mkForce "${pkgs.pinentry-rofi}/bin/pinentry-rofi";
    };
    enableSSHSupport = true;
  };
  services.samba-wsdd = {
    # make shares visible for windows 10 clients
    enable = true;
    openFirewall = true;
  };
  services.samba = {
    enable = true;
    securityType = "user";
  };
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.adb.enable = true;
  security.doas.enable = true;
  security.sudo.enable = false;
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "dbus-run-session Hyprland";
      };
      default_session = initial_session;
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}

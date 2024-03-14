{
  config,
  pkgs,
  lib,
  system,
  inputs,
  ...
}: {
  # Enable plymouth
  boot.plymouth.enable = true;
  # Enable GVFS to be able to mount and see removable devices in thunar
  services.gvfs.enable = true;
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  boot.initrd.systemd.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_PT.UTF-8";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  programs.dconf.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    # System monitor
    btop
    # Gnome disks for managing partitions
    gnome.gnome-disk-utility

    # For opening compressed archives like zip, rar, tar.gz, etc...
    gnome.file-roller

    pinentry-rofi

    pamixer
    libnotify
    pavucontrol
    neofetch
    vlc

    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${config.stylix.image}";
        backgroundMode = "fill";
        passwordCharacter = "*";
        passwordFontSize = 96;
        sessionsFontSize = 24;
        usersFontSize = 48;
        cursorColor = "#FFFFFF";
      };
    })
  ];
  environment.shells = [pkgs.nushell];

  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
  xdg.portal.config = {common = {default = ["hyprland"];};};
  xdg.portal.enable = true;

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

  # Use doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;

  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
  };
  programs.hyprland.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
  system.stateVersion = "23.11";
}

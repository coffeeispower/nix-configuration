{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enable hyprlock pam service
  security.pam.services.hyprlock = {};
  # Enable plymouth
  boot.plymouth.enable = true;
  # Enable GVFS to be able to mount and see removable devices in nautilus
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
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; LIBVA_DRIVER_NAME = "iHD"; };
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

    # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  programs.dconf.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    xdg-user-dirs
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
    fastfetch
    vlc
    
    (lib.mkIf config.services.displayManager.sddm.enable (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      background = "${config.stylix.image}";
      font = config.stylix.fonts.sansSerif.name;
      fontSize = builtins.toString config.stylix.fonts.sizes.desktop;
      loginBackground = true;
    }))
  ];
  environment.shells = [pkgs.nushell];

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

  services.displayManager.sddm = {
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
  services.displayManager.defaultSession = "hyprland";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = ".bkp";
  };
  system.stateVersion = "24.05";
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}

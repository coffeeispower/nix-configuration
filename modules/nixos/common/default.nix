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
  services.cpupower-gui.enable = true;
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
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
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
  # services.xserver.enable = true;
  # services.xserver.desktopManager.xterm.enable = false;
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
    
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      background = "${config.stylix.image}";
      font = config.stylix.fonts.sansSerif.name;
      fontSize = builtins.toString config.stylix.fonts.sizes.desktop;
      loginBackground = true;
    })
    # (pkgs.where-is-my-sddm-theme.override {
    #   themeConfig.General = {
    #     background = "${config.stylix.image}";
    #     backgroundMode = "fill";
    #     blurRadius = 10;
    #     sessionsFontSize = 24;
    #     usersFontSize = 48;
    #     showSessionsByDefault = true;
    #     cursorColor = "#${config.stylix.base16Scheme.base05}";

    #     passwordInputCursorVisible = true;
    #     passwordInputWidth = 0.25;        
    #     passwordCharacter = "*";
    #     passwordFontSize = 28;
    #     passwordInputBackground = "#60ffffff";
    #     passwordInputRadius = 10;
    #   };
    # })
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
    enable = true;
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
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "performance";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 90;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };
}

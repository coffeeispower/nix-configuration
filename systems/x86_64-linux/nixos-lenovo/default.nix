{
  pkgs,
  lib,
  inputs,
  system,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    /tmp/hardware-configuration.nix
    inputs.tibs.nixosModules.tibs
  ];

  services.preload.enable = true;
  hardware.firmware = with pkgs; [linux-firmware];
  # specialisation.tibs = {
  #   configuration = {
  #     tibs = {
  #     	enable = true;
  # tibsPath = "/home/tiago/Projects/tibs/target/debug/tibs";
  # assetsDir = "/home/tiago/Projects/tibs/assets";
  #     };
  #     boot.plymouth.enable = lib.mkForce false;
  #     services.displayManager.sddm.enable = lib.mkForce false;
  #   };
  # };

  virtualisation.waydroid.enable = true;
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
  # boot.resumeDevice = (builtins.elemAt config.swapDevices 0).device;
  services.cpupower-gui.enable = true;
  programs.nix-ld.libraries = with pkgs;
    [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      freetype
      fontconfig
      libGL
      libpulseaudio
    ]
    ++ (with pkgs.xorg; [
      libXext
      libX11
      libXrender
      libXtst
      libXi
      libXcursor
      libXinerama
      libXrandr
    ]);
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
  	inputs.woomer.packages.${system}.default
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    kdePackages.plasma-browser-integration
    kdePackages.krohnkite
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    wl-screenrec
    anki
    keepassxc
    # Custom packages

    # For virt manager
    virtiofsd

    ## Nix language server
    nil

    ## SQL Database GUI
    beekeeper-studio

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

    # Applications
    libreoffice

    evince

    # For playing some crazy games
    lutris
    wine
    wine64

    ## Minecraft Launcher
    prismlauncher

    ## For managing displays with UI
    wdisplays

    ## Notes app
    ## https://obsidian.md
    obsidian

    gimp

    ## Torrents
    transmission_4-gtk

    inkscape

    ## Code lines counter
    scc

    # For samba
    cifs-utils
    # For controlling CPU power
    cpupower-gui
    glib
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  programs.adb.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.hyprland.enable = false;
  programs.hyprland.package = inputs.hyprland.packages.${system}.hyprland;
  # services.xserver.displayManager.sddm.settings.Autologin = {
  #   Session = "hyprland.desktop";
  #   User = "tiago";
  # };

  # Enable samba for sharing and accessing shared folders
  services.samba-wsdd = {
    # make shares visible for windows 10 clients
    enable = true;
    openFirewall = true;
  };
  services.samba = {
    enable = true;
    settings.global.security = "user";
  };

  # Enable japanese input with ibus
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc pkgs.fcitx5-gtk pkgs.fcitx5-hangul];
  };
   environment.variables = {
     GTK_IM_MODULE = lib.mkForce "";
     QT_IM_MODULE = lib.mkForce "";
     NIXOS_OZONE_WL = "1";
   };
  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };

  # Enable noise torch for microphone noise cancellation
  programs.noisetorch.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  # boot.kernelParams = ["quiet" "splash"];
  # boot.consoleLogLevel = 0;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [25565 3000 5173];
    allowedUDPPortRanges = [
      {
        from = 25565;
        to = 25565;
      }
    ];
  };
  services.upower.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
}

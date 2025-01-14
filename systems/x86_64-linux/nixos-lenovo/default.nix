{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    /tmp/hardware-configuration.nix
  ];
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
  services.displayManager.sddm.enable = true;
  environment.systemPackages = with pkgs; [
    keepassxc
    # Custom packages
    my-lib.slides
    my-lib.bombsquad

    # For virt manager
    virtiofsd

    # Some development tools I use

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
  programs.hyprland.enable = true;
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
    fcitx5.addons = [pkgs.fcitx5-mozc pkgs.fcitx5-gtk];
  };
   environment.variables = {
     GTK_IM_MODULE = lib.mkForce "";
     QT_IM_MODULE = lib.mkForce "";
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

  boot.kernelParams = ["quiet" "splash"];
  boot.consoleLogLevel = 0;
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
}

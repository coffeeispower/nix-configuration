{ config, pkgs, lib, system, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  users.users.tiago = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "adbusers" ]; # Enable ‘sudo’ for the user.
    hashedPassword =
      "$y$j9T$x4wYgVWjLlUp43gVSTvj61$XX50fudyvMCLx0kvm/EHAplZ.ev1Lxj1ZrRoB4itEMA";
    shell = pkgs.nushell;
  };

  security.doas.extraRules = [{
    users = ["tiago"];
    keepEnv = true;  # Optional, retains environment variables while running commands
    persist = true;  # Optional, only require password verification a single time
  }];
  services.greetd.settings.initial_session.user = "tiago";
  boot.resumeDevice = (builtins.elemAt config.swapDevices 0).device;
  programs.nix-ld.libraries = with pkgs; [
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
  ] ++ (with pkgs.xorg; [
    libXext
    libX11
    libXrender
    libXtst
    libXi
  ]);
  programs.nix-ld.enable = true;
}

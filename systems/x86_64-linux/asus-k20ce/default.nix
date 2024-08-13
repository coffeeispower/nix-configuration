{
  config,
  pkgs,
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
      PasswordAuthentication = false;
      AllowUsers = ["tiago"];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
  users.users.tiago = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    hashedPassword = "$y$j9T$x4wYgVWjLlUp43gVSTvj61$XX50fudyvMCLx0kvm/EHAplZ.ev1Lxj1ZrRoB4itEMA";
    shell = pkgs.nushell;
  };

  security.doas.extraRules = [
    {
      users = ["tiago"];
      keepEnv = true;
      persist = true;
    }
  ];
  boot.resumeDevice = (builtins.elemAt config.swapDevices 0).device;
  environment.systemPackages = with pkgs; [
    ## Nix language server
    nil

    ## Nix formatter
    alejandra
    rcon
    rlwrap
  ];
  virtualisation.podman.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  boot.kernelParams = ["quiet" "splash"];
  boot.consoleLogLevel = 0;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 22 ];
    allowedUDPPorts = [ 5001 ];
  };
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      tequorld = {
        image = "eclipse-temurin:21-jre-alpine";
        entrypoint = "java";
        cmd = ["-jar" "server.jar"];
        workdir = "/server";
        volumes = ["/home/tiago/tequorld:/server"];
        ports = [ "25565:25565" "5001:5001/udp" "1000:1000" ];
      };
    };
  };
}

{
  inputs,
  config,
  lib,
  system,
  pkgs,
  ...
}:
let pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; }; in
with lib; {
  options.programs.hypridle = {
    enable = mkEnableOption "hypridle";
    package = mkOption {
      type = types.package;
      default = pkgs-unstable.hypridle;
      defaultText = literalExpression "pkgs-unstable.hypridle";
      description = "The package to use for hypridle.";
    };
    enableHyprlandIntegration = mkOption {
      type = types.bool;
      default = config.wayland.windowManager.hyprland.enable;
      defaultText = "`true` if hyprland is enabled, `false` otherwise.";
      description = "Start hypridle on startup";
    };
  };
  config = let
    hypridle = config.programs.hypridle;
  in {
    xdg.configFile."hypr/hypridle.conf".text = mkIf hypridle.enable ''
general {
    lock_cmd = ${pkgs.procps}/bin/pidof hyprlock || ${config.programs.hyprlock.package}/bin/hyprlock       # avoid starting multiple hyprlock instances.
    before_sleep_cmd = ${pkgs.systemd}/bin/loginctl lock-session    # lock before suspend.
    after_sleep_cmd = ${pkgs-unstable.hyprland}/bin/hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
}

listener {
    timeout = 150                                # 2:30
    on-timeout = ${pkgs.brightnessctl}/bin/brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
    on-resume = ${pkgs.brightnessctl}/bin/brightnessctl -r                 # monitor backlight restore.
}

listener {
    timeout = 180                                 # 3:00
    on-timeout = ${pkgs.systemd}/bin/loginctl lock-session            # lock screen when timeout has passed
}

listener {
    timeout = 330                                 # 5:30
    on-timeout = ${pkgs-unstable.hyprland}/bin/hyprctl dispatch dpms off        # screen off when timeout has passed
    on-resume = ${pkgs-unstable.hyprland}/bin/hyprctl dispatch dpms on          # screen on when activity is detected after timeout has fired.
}

listener {
    timeout = 1800                                # 30:00
    on-timeout = ${pkgs.systemd}/bin/systemctl hibernate                # suspend pc
}
    '';
    wayland.windowManager.hyprland.settings.exec-once = [
      (mkIf (hypridle.enableHyprlandIntegration && config.wayland.windowManager.hyprland.enable) "${hypridle.package}/bin/hypridle")
    ];
  };
}

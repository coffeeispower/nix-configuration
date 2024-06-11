{
  config,
  lib,
  pkgs,
  ...
}: {
  services.hypridle.settings = {
    general = {
      lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${config.programs.hyprlock.package}/bin/hyprlock";
      before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
      after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
    };

    listener = [
      {
        timeout = 150;
        on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
        on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      }
      {
        timeout = 180;
        on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        timeout = 330;
        on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 1800;
        on-timeout = "${pkgs.systemd}/bin/systemctl hibernate";
      }
    ];
  };
}

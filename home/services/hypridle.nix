{
  pkgs,
  inputs,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;

  niriAction = "${pkgs.niri}/bin/niri msg action";
  lockCommand = "${quickshell}/bin/qs ipc call lock lock";
in {
  services.hypridle = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = {
      general = {
        before_sleep_cmd = lockCommand;
        after_sleep_cmd = "${niriAction} power-on-monitors";

        ignore_dbus_inhibit = false;

        lock_cmd = lockCommand;
      };

      listener = [
        {
          timeout = 15 * 60;
          on-timeout = lockCommand;
        }

        {
          timeout = 20 * 60;
          on-timeout = "${niriAction} power-off-monitors";
          on-resume = "${niriAction} power-on=monitors";
        }
      ];
    };
  };
}

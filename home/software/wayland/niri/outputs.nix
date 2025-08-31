{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  computerName = vars.name;

  lenovoOutputs = {
    "eDP-1" = {
      scale = 1.0;

      position = {
        x = 0;
        y = 0;
      };
    };
  };
in {
  programs.niri.settings.outputs =
    if computerName == "lenovo"
    then lenovoOutputs
    else abort "Unknown computer name";
}

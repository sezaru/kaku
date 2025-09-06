{vars, ...}: let
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

  macbookOutputs = {
    "eDP-1" = {
      scale = 1.2;

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
    else if computerName == "macbook"
    then macbookOutputs
    else abort "Unknown computer name";
}

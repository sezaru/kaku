{vars, ...}: let
  name = vars.name;
  keyboardType = vars.keyboardType;
in {
  programs.niri.settings.input = {
    keyboard = {
      xkb = {
        layout = "us";

        options =
          if keyboardType == "normal"
          then "altwin:swap_lalt_lwin,compose:ralt"
          else if keyboardType == "mac"
          then "compose:ralt"
          else abort "Unkown keyboard type";
      };

      repeat-delay = 200;
      repeat-rate = 25;

      track-layout = "global";
    };

    touchpad = {
      dwt = true;
      tap =
        if name == "macbook"
        then false
        else true;
      natural-scroll = false;
    };

    focus-follows-mouse = {
      enable = true;
      max-scroll-amount = "90%";
    };

    # warp-mouse-to-focus.enable = true;
    # workspace-auto-back-and-forth = true;
  };
}

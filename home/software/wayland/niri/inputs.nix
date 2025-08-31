{vars, ...}: let
  keyboardType = vars.keyboardType;
in {
  programs.niri.settings.input = {
    keyboard = {
      xkb = {
        layout = "us";

        options =
          if keyboardType == "normal"
          then "altwin:swap_lalt_lwin,compose:ralt,ctrl:nocaps"
          else if keyboardType == "mac"
          then "compose:ralt,ctrl:nocaps"
          else abort "Unkown keyboard type";
      };

      repeat-delay = 200;
      repeat-rate = 25;

      track-layout = "global";
    };

    touchpad = {
      dwt = true;
      tap = true;
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

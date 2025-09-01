{
  config,
  pkgs,
  ...
}: let
  pointer = config.home.pointerCursor;
in {
  programs.niri = {
    enable = true;

    package = pkgs.niri;

    settings = {
      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

      prefer-no-csd = true;

      layout = {
        gaps = 8;

        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };

        focus-ring = {
          enable = true;

          width = 2;
          active.color = "#7FC8FF";
          inactive.color = "#505050";
        };

        border.enable = false;

        shadow = {
          enable = true;

          offset = {
            x = 0;
            y = 5;
          };

          softness = 10;
          spread = 5;
          draw-behind-window = false;
          color = "#000F";
        };

        default-column-width = {
          proportion = 0.5;
        };

        preset-column-widths = [
          {proportion = 0.333330;}
          {proportion = 0.500000;}
          {proportion = 0.666670;}
        ];

        center-focused-column = "never";
      };

      cursor = {
        size = pointer.size;
        theme = "${pointer.name}";
        hide-after-inactive-ms = 3000;
      };

      hotkey-overlay.skip-at-startup = true;

      spawn-at-startup = [
        # (makeCommand "hyprlock")
        {command = ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];}
        {command = ["${pkgs.wl-clipboard}/bin/wl-paste" "--watch" "cliphist" "store"];}
        {command = ["${pkgs.wl-clipboard}/bin/wl-paste" "--type text" "--watch" "cliphist" "store"];}
        {command = ["qs"];}
      ];

      gestures = {
        hot-corners.enable = true;
      };
    };
  };
}

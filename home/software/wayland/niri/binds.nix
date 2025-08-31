{
  config,
  pkgs,
  inputs,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    quickshellIpc = spawn "${quickshell}/bin/qs" "ipc" "call";
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
    ghostty = spawn "${pkgs.ghostty}/bin/ghostty";
    # TODO See if we can get this from pkgs
    zen = spawn "zen";
    nautilus = spawn "${pkgs.nautilus}/bin/nautilus";
  in {
    "XF86MonBrightnessUp".action = quickshellIpc "brightness" "increment" "5" "";
    "XF86MonBrightnessDown".action = quickshellIpc "brightness" "decrement" "5" "";

    "XF86KbdBrightnessUp".action = quickshellIpc "brightness" "increment" "5" "kbd_backlight";
    "XF86KbdBrightnessDown".action = quickshellIpc "brightness" "decrement" "5" "kbd_backlight";

    "XF86AudioMute".action = quickshellIpc "audio" "mute";
    "XF86AudioMicMute".action = quickshellIpc "audio" "micmute";

    "XF86AudioRaiseVolume".action = quickshellIpc "audio" "increment" "3";
    "XF86AudioLowerVolume".action = quickshellIpc "audio" "decrement" "3";

    "XF86AudioPlay".action = playerctl "play-pause";
    "XF86AudioStop".action = playerctl "pause";
    "XF86AudioPrev".action = playerctl "previous";
    "XF86AudioNext".action = playerctl "next";

    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;

    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;
    "Mod+Ctrl+5".action.move-column-to-workspace = 5;
    "Mod+Ctrl+6".action.move-column-to-workspace = 6;
    "Mod+Ctrl+7".action.move-column-to-workspace = 7;
    "Mod+Ctrl+8".action.move-column-to-workspace = 8;
    "Mod+Ctrl+9".action.move-column-to-workspace = 9;

    "Mod+B".action = zen;
    "Mod+E".action = nautilus;

    "Mod+Return" = {
      action = ghostty;
      hotkey-overlay.title = "Open a terminal: ghostty";
    };

    "Mod+Ctrl+Return" = {
        action = quickshellIpc "spotlight" "toggle";
        hotkey-overlay.title = "Application Launcher";
    };

    "XF86Search".action = quickshellIpc "spotlight" "toggle";

    "Mod+O" = {
        action = toggle-overview;
        repeat = false;
    };

    "Mod+C".action = center-visible-columns;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = expand-column-to-available-width;
    "Mod+Q".action = close-window;
    "Mod+S".action = switch-preset-column-width;
    "Mod+Space".action = toggle-window-floating;

    "Mod+W".action = toggle-column-tabbed-display;
    "Mod+Tab".action = switch-focus-between-floating-and-tiling;

    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;

    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;

    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;

    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+L".action = move-column-right;
    "Mod+Shift+K".action = move-column-to-workspace-up;
    "Mod+Shift+J".action = move-column-to-workspace-down;

    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";

    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    "Mod+P".action.screenshot = {show-pointer = false;};

    "Mod+Shift+Slash".action = show-hotkey-overlay;

    # "Ctrl+Alt+L".action = spawn "sh -c pgrep hyprlock || hyprlock";
  };
}

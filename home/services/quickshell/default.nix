{
  pkgs,
  inputs,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
  dgop = inputs.dgop.packages.${pkgs.system}.dgop;
in {
  home.packages = [
    quickshell

    dgop
    pkgs.matugen
    pkgs.khal
    pkgs.ddcutil
    pkgs.gammastep
    pkgs.cliphist
    pkgs.wl-clipboard
    pkgs.brightnessctl
    pkgs.cava

    pkgs.glib
    pkgs.networkmanager

    pkgs.fira-code
    pkgs.inter-nerdfont
    pkgs.material-symbols
  ];

  xdg.configFile = {
    "quickshell" = {
      source = builtins.fetchGit {
        url = "https://github.com/AvengeMedia/DankMaterialShell.git";
        rev = "4b7a43fccd491846f5cde91519945114025edff8";
      };

      executable = false;
      recursive = true;
    };
  };
}

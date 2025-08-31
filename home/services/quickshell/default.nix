{
  pkgs,
  inputs,
  lib,
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
    pkgs.gammastep
    pkgs.cliphist
  ];

  xdg.configFile = {
    "quickshell" = {
      source = builtins.fetchGit {
        url = "https://github.com/AvengeMedia/DankMaterialShell.git";
        rev = "a8901895307f665a53f75783c9dcdb8e118591e0";
      };

      executable = false;
      recursive = true;
    };
  };
}

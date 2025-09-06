{
  pkgs,
  inputs,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in {
  programs.dankMaterialShell = {
    enable = true;
    enableSpawn = true;
    enableCalendarEvents = false;

    quickshell.package = quickshell;
  };
}

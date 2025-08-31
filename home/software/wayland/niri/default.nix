{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    ./inputs.nix
    ./outputs.nix
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];
}

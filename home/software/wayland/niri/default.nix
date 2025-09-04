{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    ./envs.nix
    ./inputs.nix
    ./outputs.nix
    ./settings.nix
    ./binds.nix
    ./rules.nix
    ./debug.nix
  ];
}

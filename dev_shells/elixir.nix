{
  inputs,
  pkgs,
  ...
}:
inputs.devenv.lib.mkShell {
  inherit inputs pkgs;

  modules = [
    ({pkgs, ...}: {
      # This is your devenv configuration
      packages = [pkgs.hello];

      enterShell = ''
        hello
      '';

      processes.run.exec = "hello";
    })
  ];
}

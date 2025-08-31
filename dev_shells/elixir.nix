{ lib, inputs, pkgs, ... }:

{
  devenv.lib.mkShell {
    inherit inputs pkgs;

    modules = [
      ({ pkgs, config, ... }: {
        # This is your devenv configuration
        packages = [ pkgs.hello ];

        enterShell = ''
              hello
            '';

        processes.run.exec = "hello";
      })
    ];
  };
}

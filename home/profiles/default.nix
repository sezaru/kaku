{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "sezdocs@lenovo" = [
      ../.
      ./lenovo
    ];

    "sezdocs@macbook" = [
      ../.
      ./macbook
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfiguration = {
      "sezdocs@lenovo" = homeManagerConfiguration {
        modules = homeImports."sezdocs@lenovo";
        inherit pkgs extraSpecialArgs;
      };

      "sezdocs@macbook" = homeManagerConfiguration {
        modules = homeImports."sezdocs@macbook";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}

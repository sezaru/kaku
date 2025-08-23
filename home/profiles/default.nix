{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "sezdocs@aesthetic" = [
      ../.
      ./aesthetic
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfiguration = {
      "sezdocs_aesthetic" = homeManagerConfiguration {
        modules = homeImports."sezdocs@aesthetic";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}

{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    lenovo = nixosSystem {
      inherit specialArgs;
      modules =
        desktop
        ++ laptop
        ++ [
          ./lenovo
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"
          "${mod}/core/lanzaboote.nix"
          {
            home-manager = {
              users.sezdocs.imports =
                homeImports."sezdocs@lenovo";
              extraSpecialArgs = specialArgs;
            };
          }

          inputs.agenix.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
    };
  };
}

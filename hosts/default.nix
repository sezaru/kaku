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
  in {
    lenovo = nixosSystem rec {
      specialArgs = {
        inherit inputs self;

        vars = {
          name = "lenovo";
          type = "laptop";
          keyboardType = "normal";
          gpu = "amd";
        };
      };

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

    macbook = nixosSystem rec {
      specialArgs = {
        inherit inputs self;

        vars = {
          name = "macbook";
          type = "laptop";
          keyboardType = "mac";
          gpu = "mac";
        };
      };

      modules =
        desktop
        ++ laptop
        ++ [
          ./macbook
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"
          "${mod}/core/lanzaboote.nix"
          {
            home-manager = {
              users.sezdocs.imports =
                homeImports."sezdocs@macbook";
              extraSpecialArgs = specialArgs;
            };
          }

          inputs.agenix.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
    };
  };
}

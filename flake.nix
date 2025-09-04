{
  description = "LinuDev Configuration NixOs.";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [./home/profiles ./hosts];

      perSystem = {pkgs, ...}: {
        devShells = {
          elixir = import ./dev_shells/elixir.nix {inherit inputs pkgs;};
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    # global, so they can be `.follow`ed
    systems.url = "github:nix-systems/default-linux";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # rest of inputs, alphabetical order
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "hm";
      inputs.systems.follows = "systems";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote.url = "github:nix-community/lanzaboote";

    # TODO Custom nix packages, check how to create it
    mynixpkgs.url = "github:linuxmobile/mynixpkgs";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asahi = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:pfaj/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    doom-emacs = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };
  };
}

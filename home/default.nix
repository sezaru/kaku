{inputs, ...}: {
  imports = [
    ./terminal
    inputs.nix-index-db.homeModules.nix-index
    inputs.doom-emacs.homeModule
  ];

  home = {
    username = "sezdocs";
    homeDirectory = "/home/sezdocs";
    stateVersion = "25.05";
  };

  # Disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # Let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  stylix = {
    targets = {
      bat.enable = true;
      nixos-icons.enable = true;
      starship.enable = true;
      yazi.enable = true;
      # hyprlock.enable = true;
      # swaylock.enable = true;
    };
  };

  home.file.".face" = {
    source = ./users/sezdocs.png;
  };
}

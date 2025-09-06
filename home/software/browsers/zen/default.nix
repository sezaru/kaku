{inputs, ...}: {
  imports = [
    inputs.zen-browser.homeModules.twilight

    ./stylix.nix
    ./settings.nix
    ./bookmarks.nix
    ./extensions.nix
    ./search_engines.nix
  ];

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
    };
  };
}

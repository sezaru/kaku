{
  config,
  lib,
  pkgs,
  ...
}: let
  searchNixpkgs = {
    name = "nixpkgs";
    urls = [
      {
        template = "https://search.nixos.org/packages";
        params = [
          {
            name = "type";
            value = "packages";
          }
          {
            name = "query";
            value = "{searchTerms}";
          }
        ];
        definedAliases = ["@np"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      }
    ];
  };

  searchNixwiki = {
    name = "nixwiki";
    urls = [
      {
        teamplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
      }
    ];
    iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
    definedAliases = ["@nw"];
  };
in {
  programs.zen-browser.profiles.default.search = {
    force = true;

    default = "google";
    privateDefault = "ddg";

    order = ["google" "ddg"];

    engines = {
      # TODO Doesn't seem to work
      nixpkgs = searchNixpkgs;
      nixwiki = searchNixwiki;

      bing.metaData.hidden = true;

      google.metaData.alias = "@g";
    };
  };
}

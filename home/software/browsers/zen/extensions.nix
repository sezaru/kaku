{pkgs, ...}: {
  programs.zen-browser.profiles.default.extensions = {
    force = true;

    packages = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      proton-vpn
      improved-tube
    ];
  };
}

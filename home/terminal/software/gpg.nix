{config, ...}: {
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    settings = {
      use-agent = true;
      # TODO Fix this
      default-key = "481EFFCF2C7B8C7B";
    };
  };
}

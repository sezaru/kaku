{pkgs, ...}: {
  systemd.services.tiny-dfr = {
    description = "Tiny Apple silicon touch bar daemon";

    enable = true;

    after = [
      "getty@tty1.service"
    ];

    before = [
      "desktop-manager.service"
    ];
  };
}

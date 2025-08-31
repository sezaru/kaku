{pkgs, ...}: {
  home.packages = [
    pkgs.fzf
  ];

  programs.fish = {
    enable = true;

    shellInit = ''
      set -gx NIXPKGS_ALLOW_UNFREE 1
      set -gx NIXPKGS_ALLOW_INSECURE 1
      set -gx EDITOR emacs
      set -gx VISUAL emacs

      set -g fish_greeting
    '';

    interactiveShellInit = ''
      set -g fish_color_autosuggestion brblack
      set -g fish_color_command blue
      set -g fish_color_error red
      set -g fish_color_param normal

      fish_add_path ~/.local/bin
      set -g fish_color_search_match --background=normal
    '';

    functions = {
      fcd = ''
        set -l dir (${pkgs.fd}/bin/fd --type d | ${pkgs.skim}/bin/sk | string trim)
        if test -n "$dir"
          cd $dir
        end
      '';

      installed = ''
        nix-store --query --requisites /run/current-system/ | string replace -r '.*?-(.*)' '$1' | sort | uniq | ${pkgs.skim}/bin/sk
      '';

      installedall = ''
        nix-store --query --requisites /run/current-system/ | ${pkgs.skim}/bin/sk | ${pkgs.wl-clipboard}/bin/wl-copy
      '';

      fm = ''
        set -l tmp (mktemp -t "yazi-cwd.XXXXX")
        ${pkgs.yazi}/bin/yazi $argv --cwd-file $tmp
        set -l cwd (cat $tmp)
        if test -n "$cwd" -a "$cwd" != "$PWD"
          cd $cwd
        end
        rm -f $tmp
      '';

      gitgrep = ''
        ${pkgs.git}/bin/git ls-files | ${pkgs.ripgrep}/bin/rg $argv
      '';

      dev = "nix develop --impure /etc/nixos#$argv --command fish";
    };

    shellAbbrs = {
      z = "${pkgs.zoxide}/bin/zoxide query";
      zi = "${pkgs.zoxide}/bin/zoxide query -i";
    };

    shellAliases = {
      cleanup = "${pkgs.nh}/bin/nh clean all";
      listgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nixremove = "nix-store --gc";
      bloat = "nix path-info -Sh /run/current-system";
      cleanram = "sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'";
      trimall = "sudo ${pkgs.util-linux}/bin/fstrim -va";

      c = "clear";
      q = "exit";
      temp = "cd /tmp/";

      test-build = "${pkgs.nh}/bin/nh os test /etc/nixos";
      switch-build = "${pkgs.nh}/bin/nh os switch /etc/nixos";

      l = "${pkgs.eza}/bin/eza -lF --time-style=long-iso --icons";
      ll = "${pkgs.eza}/bin/eza -h --git --icons --color=auto --group-directories-first -s extension";
      tree = "${pkgs.eza}/bin/eza --tree --icons --tree";
    };

    plugins = with pkgs.fishPlugins; [
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "done";
        src = done.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
      {
        name = "fish-you-should-use";
        src = fish-you-should-use.src;
      }
      {
        name = "humantime-fish";
        src = humantime-fish.src;
      }
      {
        name = "fifc";
        src = fifc.src;
      }
    ];
  };
}

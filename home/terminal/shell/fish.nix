{
  lib,
  pkgs,
  vars,
  ...
}: {
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
        set -l dir (${lib.getExe pkgs.fd} --type d | ${lib.getExe pkgs.skim} | string trim)
        if test -n "$dir"
          cd $dir
        end
      '';

      installed = ''
        nix-store --query --requisites /run/current-system/ | string replace -r '.*?-(.*)' '$1' | sort | uniq | ${lib.getExe pkgs.skim}
      '';

      installedall = ''
        nix-store --query --requisites /run/current-system/ | ${lib.getExe pkgs.skim} | ${pkgs.wl-clipboard}/bin/wl-copy
      '';

      fm = ''
        set -l tmp (mktemp -t "yazi-cwd.XXXXX")
        ${lib.getExe pkgs.yazi} $argv --cwd-file $tmp
        set -l cwd (cat $tmp)
        if test -n "$cwd" -a "$cwd" != "$PWD"
          cd $cwd
        end
        rm -f $tmp
      '';

      gitgrep = ''
        ${lib.getExe pkgs.git} ls-files | ${lib.getExe pkgs.ripgrep} $argv
      '';

      dev = "nix develop --no-pure-eval /etc/nixos#$argv --profile /etc/nixos/.profiles/$argv --command fish";

      # To generate the key and store it into the Yubikey, run the following command:
      # ssh-keygen -t ecdsa-sk -O resident -O application=ssh:<name of profile>
      import_ssh_key = ''
        set -l tmp (mktemp -d -t "ssh-cwd.XXXXX")
        pushd $tmp
        pwd
        ssh-keygen -K
        mv id_ecdsa*${vars.name}.pub ~/.ssh/id_ecdsa.pub
        mv id_ecdsa*${vars.name} ~/.ssh/id_ecdsa
        popd
        rm -f $tmp
      '';
    };

    shellAbbrs = {
      z = "${lib.getExe pkgs.zoxide} query";
      zi = "${lib.getExe pkgs.zoxide} query -i";
    };

    shellAliases = {
      cleanup = "${lib.getExe pkgs.nh} clean all";
      listgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nixremove = "nix-store --gc";
      bloat = "nix path-info -Sh /run/current-system";
      cleanram = "sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'";
      trimall = "sudo ${pkgs.util-linux}/bin/fstrim -va";

      c = "clear";
      q = "exit";

      rm = "${lib.getExe pkgs.gtrash} put";

      grep = lib.getExe pkgs.ripgrep;

      df = lib.getExe pkgs.du-dust;

      test-build = "${lib.getExe pkgs.nh} os test /etc/nixos";
      switch-build = "${lib.getExe pkgs.nh} os switch /etc/nixos";

      l = "${lib.getExe pkgs.eza} -lF --time-style=long-iso --icons";
      ll = "${lib.getExe pkgs.eza} -h --git --icons --color=auto --group-directories-first -s extension";
      tree = "${lib.getExe pkgs.eza} --tree --icons --tree";
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

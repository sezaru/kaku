{pkgs, ...}: {
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
      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      set -g fish_color_autosuggestion brblack
      set -g fish_color_command blue
      set -g fish_color_error red
      set -g fish_color_param normal

      fish_add_path ~/.local/bin
      set -g fish_color_search_match --background=normal
    '';

    functions = {
      fcd = ''
        set -l dir (fd --type d | sk | string trim)
        if test -n "$dir"
          cd $dir
        end
      '';

      installed = ''
        nix-store --query --requisites /run/current-system/ | string replace -r '.*?-(.*)' '$1' | sort | uniq | sk
      '';

      installedall = ''
        nix-store --query --requisites /run/current-system/ | sk | wl-copy
      '';

      fm = ''
        set -l tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file $tmp
        set -l cwd (cat $tmp)
        if test -n "$cwd" -a "$cwd" != "$PWD"
          cd $cwd
        end
        rm -f $tmp
      '';

      gitgrep = ''
        git ls-files | rg $argv
      '';
    };

    shellAbbrs = {
      z = "zoxide query";
      zi = "zoxide query -i";
    };

    shellAliases = {
      cleanup = "sudo nix-collect-garbage --delete-older-than 1d";
      listgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nixremove = "nix-store --gc";
      bloat = "nix path-info -Sh /run/current-system";
      cleanram = "sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'";
      trimall = "sudo fstrim -va";

      c = "clear";
      q = "exit";
      temp = "cd /tmp/";

      test-build = "nh os test /etc/nixos";
      switch-build = "nh os switch /etc/nixos";

      l = "eza -lF --time-style=long-iso --icons";
      ll = "eza -h --git --icons --color=auto --group-directories-first -s extension";
      tree = "eza --tree --icons --tree";
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

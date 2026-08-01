{
  flake.homeModules.bash = {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [ "ignoreboth" ];
      initExtra = ''
        set -o vi
        bind -m vi-command ".":insert-last-argument
        bind -m vi-command '"-":yank-nth-arg'
        bind -m vi-command "=":edit-and-execute-command

        function r() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }

        # fuzzy cd and fancy ls -lh
        function c() {
          local dir
          dir="$( fd --type d -H -d 5 | fzf )"
          [[ -z $dir ]] && return
          cd "$dir"
          yazi
        }

        # fuzzy search for a file in the current directory and open it in $EDITOR.
        function f() {
          local file
          file="$(fd --type f -HL | fzf --preview='bat --color always {}')"
          [[ -z $file ]] && return

          cd "$(dirname $file)"
          $EDITOR "$(basename $file)"
        }

        # fuzzy search for a file in the Projects directory and open it in $EDITOR.
        function j() {
          local file
          file="$(fd --type f -HL . '/home/simon/Projects' | fzf --preview='bat --color always {}')"
          [[ -z $file ]] && return

          cd "$(dirname $file)"
          $EDITOR "$file"
        }

        # fuzzy search for a file in a directory under $HOME
        # narrowing by directory, and open it in $EDITOR.
        function ff() {
          local dir
          dir="$( fd --type d -H . -d 1 ~/ | fzf )"
          [[ -z $dir ]] && return

          local file
          file="$(fd --type f -HL . $dir | fzf --preview='bat --color always {}')"
          [[ -z $file ]] && return

          cd "$(dirname $file)"
          $EDITOR "$file"
        }

        # source api keys
        [[ -f ~/.api_keys ]] && . ~/.api_keys

        # eval "$(zoxide init bash)"
        [[ -f /home/$USER/.nix-profile/share/bash/bash-preexec.sh ]] && source /home/$USER/.nix-profile/share/bash/bash-preexec.sh
        eval "$(atuin init bash --disable-up-arrow)"
      '';
      shellAliases =
        let
          flakeDir = "~/.nixos/";
        in
        {
          gc = "cd ~/.config";
          gd = "cd ~/Documents";
          gf = "cd ~/.dotfiles";
          gj = "cd ~/Projects";
          gm = "cd ~/Music";
          gn = "cd ${flakeDir}";
          gw = "cd ~/Downloads";
          gp = "cd ~/Pictures";
          gr = "cd ~/Repos";
          gt = "cd /tmp";
          gv = "cd ~/Videos";
          gcm = "git commit -m ";
          gfi = "git commit -m \"fixup!\"";
          gst = "git status";
          gla = "git log --all --graph --decorate";
          gac = "git add . && git commit -m ";
          glo = "git log --all --graph --decorate --oneline";
          gsh = "git show";
          gca = "git commit --amend";
          gri = "git rebase --interactive";
          # r = "yazi"; Moved to function - see initExtra attribute.
          rebuild = "sudo nixos-rebuild switch --flake ${flakeDir}";
          rehome = "home-manager switch --flake ${flakeDir}";
          update = "nix flake update --flake ${flakeDir}";
          upgrade = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";
        };
    };

    home.sessionVariables = {
      XDG_SCREENSHOTS_DIR = "/home/simon/Pictures/screenshots";
      ASPELL_LANG = "en_GB-ise";
    };

    home.file.inputrc = {
      target = ".inputrc";
      text = ''
        set show-mode-in-prompt on
        set vi-ins-mode-string "+"
        set vi-cmd-mode-string ":"
      '';
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

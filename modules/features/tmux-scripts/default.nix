{ self, moduleWithSystem, ... }: {
  perSystem = { pkgs, ... }: {
    packages = {
      menu-tmx = pkgs.writeShellApplication {
        name = "menu.tmx";
        runtimeInputs = [
          pkgs.fzf
        ];
        text = ''
          display_menu() {
            cat << EOF
          5. Switch
          4. New
          3. Detached
          2. List
          1. Kill
          EOF
          }

          mode="$(display_menu | fzf)"

          case $mode in
            "5. Switch") tmux-sessionizer.sh ;;
            "4. New") read -rp "Enter new session name: " session \
              && tmux-sessionizer.sh "$session" ;;
            "3. Detached") read -rp "Enter new detached session name: " session \
              && tmux new-session -s "$session" -d ;;
            "2. List") tmux list-sessions; echo -e "\n"; \
              read -rp "Press any key to continue..."  ;;
            "1. Kill") tmux-kill-session ;;
            *) notify-send "Tmux menu" "No action taken";;
          esac
        '';
      };

      sessionizer = pkgs.writeShellApplication {
        name = "tmux-sessionizer.sh";
        runtimeInputs = [
          pkgs.tmux
          pkgs.fzf
          pkgs.fd
        ];
        bashOptions = [
          "errexit"
          "pipefail"
        ];
        text = ''

          function tmux_attached() {
            attached="$(tmux list-sessions -F \
              '#{session_attached} #{session_name}' | grep ^1)"
            if [[ -n $attached ]]; then
              # return true
              return 0
            else
              return 1
            fi
          }

          # Do we already know what session we want?
          if [[ $# -eq 1 ]]; then
            session="$1"
          fi

          # Do we want an already running session?
          if [[ -z $session ]]; then
            session=$(tmux list-sessions | cut -d: -f1 | fzf --prompt='Pick session or C-c for new session: ')
          fi

          # If not, then pick a folder for a new session.
          if [[ -z $session ]]; then
            path=$(fd --type d -HL . ~/ | fzf --prompt="Pick folder or C-c to cancel: ")
            [[ -z $path ]] && exit 0
            session=$(basename "$path" | tr . _)
            # [[ -z $path ]] && path=$dir
          fi

          # Create the session if it doesn't exist...
          if ! tmux has-session -t "$session" > /dev/null 2>&1; then
            tmux new-session -s "$session" -d -c "$path"
          fi

          # ...and switch to it.
          if tmux_attached; then
            # whenever a client is attached, we switch with switch-client.
            # this method allows this script to be called (with an argument)
            # from dmenu.
            tmux switch-client -t "$session"
          else
            # This needs to be run in a terminal, and tmux will start in that terminal.
            # tmux-sessionizer is used in the tmux_ready function.
            # Will this code ever be reached in practice?
            tmux attach -t "$session"
          fi

          exit 0
        '';
      };

      kill-session = pkgs.writeShellApplication {
        name = "tmux-kill-session";
        runtimeInputs = [
          pkgs.tmux
          pkgs.fzf
        ];
        text = ''
          main() {
            mode=$(echo -e \
              "2. Kill another session\n1. Kill this session and switch\n" \
              | fzf --prompt='What do you want to do? ')

            [[ -z $mode ]] && exit

            this_session=$(tmux list-sessions -F '#{session_attached} #{session_name}' | grep ^1 | cut -d' ' -f2)

            if [[ $mode == "1. "* ]]; then
              switch_and_kill_this
            else
              kill_another
            fi
          }

          switch_and_kill_this() {
            destination=$(pick_session "Pick session to switch to: ")
            tmux switch-client -t "$destination" && tmux kill-session -t "$this_session"
          }

          kill_another() {
            target=$(pick_session "Pick session to kill: ")
            tmux kill-session -t "$target"
          }

          pick_session() {
            session=$(tmux list-sessions | cut -d: -f1 | sed "/^$this_session/d" | fzf --prompt="$1")
            echo "$session"
          }

          main
        '';
      };
    };
  };

  flake.homeModules.tmuxScripts = moduleWithSystem (
    { self', ... }: {
      home.packages = [
        self'.packages.menu-tmx
        self'.packages.sessionizer
        self'.packages.kill-session
      ];
    }
  );
}

{ pkgs, ... }:
let
  layoutSwitcher = pkgs.writeShellApplication {
    name = "layout-switcher.sh";
    runtimeInputs = [
      pkgs.noctalia
      pkgs.libnotify
    ];
    text = ''
      ws="$(hyprctl activeworkspace | head -n 1 | cut -d' ' -f3)"

      set_master() {
        hyprctl eval "hl.workspace_rule({ workspace = $ws,  layout = \"master\", layout_opts = { orientation = \"$1\"}})"
      }

      set_layout() {
        hyprctl eval "hl.workspace_rule({ workspace = $ws,  layout = \"$1\"})"
      }

      layout="$(printf '%s\n' 'master (left)' 'master (right)' 'master (top)' 'master (bottom)' 'monocle' 'scrolling' | noctalia dmenu -p 'Pick layout')"

      case $layout in
        'master (left)') set_master "left" ;;
        'master (right)') set_master "right" ;;
        'master (top)') set_master "top" ;;
        'master (bottom)') set_master "bottom" ;;
        monocle | scrolling) set_layout "$layout" ;;
        *) notify-send "layout switcher" "No action taken" ;;
      esac
    '';
  };

in
{
  home.packages = [
    layoutSwitcher
  ];
}

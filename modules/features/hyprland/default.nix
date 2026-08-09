{
  flake.homeModules.hyprland =
    { pkgs, ... }:
    {

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        extraLuaFiles = {
          "ui.autostart" = {
            content = ./hypr/autostart.lua;
            autoLoad = true;
          };
          "ui.monitors" = {
            content = ./hypr/monitors.lua;
            autoLoad = true;
          };
          "ui.bindings" = {
            content = ./hypr/bindings.lua;
            autoLoad = true;
          };
          "ui.input" = {
            content = ./hypr/input.lua;
            autoLoad = true;
          };
          "ui.layouts" = {
            content = ./hypr/layouts.lua;
            autoLoad = true;
          };
          "ui.looks" = {
            content = ./hypr/looks.lua;
            autoLoad = true;
          };
          "ui.windows" = {
            content = ./hypr/windows.lua;
            autoLoad = true;
          };
          "ui.misc" = {
            content = ./hypr/misc.lua;
            autoLoad = true;
          };
        };
        systemd = {
          enable = false;
          variables = [ "--all" ];
        };

      };

      home.packages = with pkgs; [
        hyprpaper
        hyprshot
        hyprpicker
        xdg-desktop-portal-gtk
      ];

      home.sessionVariables = {
        HYPRSHOT_DIR = "/home/simon/Pictures/screenshots";
        # Optional, hint Electron apps to use Wayland:
        NIXOS_OZONE_WL = "1";
        # VK_ICD_FILENAMES etc are set in the whisper module.
        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
      };
    };
}

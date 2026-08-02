{
  flake.homeModules.hyprland =
    { pkgs, ... }:
    # let
    #   wlogout' = pkgs.wlogout.overrideAttrs (
    #     finalAttrs: prevAttrs: {
    #       postPatch = prevAttrs.postPatch + ''
    #         substituteInPlace layout \
    #           --replace-fail "loginctl lock-session" "swaylock"
    #
    #         substituteInPlace layout \
    #           --replace-fail  "loginctl terminate-user \$USER" "uwsm stop"
    #       '';
    #     }
    #   );
    # in
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

      # services.hyprpaper = {
      #   enable = true;
      #   settings = {
      #     splash = true;
      #     splash_offset = 1;
      #     preload = [
      #       "/home/simon/.nixos/_assets/nixos-wallpaper-catppuccin-mocha.png"
      #     ];
      #     wallpaper = [
      #       {
      #         monitor = "eDP-1";
      #         path = "/home/simon/.nixos/_assets/nixos-wallpaper-catppuccin-mocha.png";
      #         fit_mode = "cover";
      #       }
      #       {
      #         monitor = "";
      #         path = "/home/simon/.nixos/_assets/nixos-wallpaper-catppuccin-mocha.png";
      #         fit_mode = "cover";
      #       }
      #     ];
      #   };
      # };

      # services.hypridle = {
      #   enable = true;
      #   settings = {
      #     general = {
      #       ignore_dbus_inhibit = false;
      #       ignore_systemd_inhibit = false;
      #     };
      #     listener = [
      #       {
      #         timeout = 300;
      #         on-timeout = "swaylock";
      #       }
      #       {
      #         timeout = 600;
      #         on-timeout = "hyprctl dispatch dpms off";
      #         on-resume = "hyprctl dispatch dpms on";
      #       }
      #     ];
      #   };
      # };

      # programs.swaylock = {
      #   enable = true;
      #   settings = {
      #     image = "${./../../../_assets/nix-wallpaper-binary-black.png}";
      #     color = "1e1e2e";
      #     font-size = 18;
      #     indicator-idle-visible = false;
      #     indicator-radius = 100;
      #     line-color = "74c7ec";
      #     show-failed-attempts = true;
      #   };
      # };

      home.packages = with pkgs; [
        hyprpaper
        hyprshot
        hyprpicker
        # swaylock
        # waybar
        # wlogout'
        xdg-desktop-portal-gtk
      ];

      home.sessionVariables = {
        HYPRSHOT_DIR = "/home/simon/Pictures/screenshots";
        # Optional, hint Electron apps to use Wayland:
        NIXOS_OZONE_WL = "1";
        WGPU_ADAPTER_NAME = "AMD Radeon RX 7800 XT (RADV NAVI32)";
        # VK_ICD_FILENAMES etc are set in the whisper module.
        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
      };
    };
}

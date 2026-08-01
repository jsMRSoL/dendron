{
  flake.homeModules.dunst =
    { pkgs, ... }:
    {
      services.dunst = {
        enable = true;
        iconTheme = {
          name = "papirus";
          package = pkgs.papirus-icon-theme;
          size = "32x32";
        };
        settings = {
          global = {
            width = 300;
            height = 300;
            offset = "20x20";
            origin = "top-right";
            separator_height = 4;
            padding = 8;
            horizontal_padding = 8;
            text_icon_padding = 4;
            frame_width = 2;
            frame_color = "#89b4fa";
            transparency = 10;
            notification_limit = 20;
            font = "FiraCode Nerd Font Mono Med 11";
            format = "<i>%a</i>\n%s\n<b>%b</b>";
            alignment = "center";
            sort = "yes";
          };

          urgency_low = {
            frame_color = "#a6e3a1";
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            timeout = 5;
            default_icon = "/home/simon/.nix-profile/share/icons/Papirus/32x32/status/dialog-question.svg";
          };
          urgency_normal = {
            frame_color = "#89b4fa";
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            timeout = 10;
            default_icon = "/home/simon/.nix-profile/share/icons/Papirus/32x32/status/dialog-information.svg";
          };
          urgency_critical = {
            frame_color = "#fab387";
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            timeout = 0;
            default_icon = "/home/simon/.nix-profile/share/icons/Papirus/32x32/status/dialog-error.svg";
          };
        };
      };
    };
}

{
  flake.homeModules.waybar =
    { pkgs, osConfig, ... }:
    let
      waybar-config =
        if osConfig.networking.hostName == "derek" then
          builtins.readFile ./config-derek.jsonc
        else
          builtins.readFile ./config.jsonc;
    in
    {
      home.packages = with pkgs; [
        waybar
      ];

      xdg.configFile."waybar-config" = {
        enable = true;
        # source = ./config.jsonc;
        # text = "${customised}";
        text = "${waybar-config}";
        target = "waybar/config.jsonc";
      };

      xdg.configFile."waybar-css" = {
        enable = true;
        source = ./style.css;
        target = "waybar/style.css";
      };

      services.blueman-applet.enable = false;
    };
}

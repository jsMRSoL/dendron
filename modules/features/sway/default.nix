{
  flake.homeModules.sway =
    { pkgs, ... }:
    {
      xdg.configFile."sway" = {
        enable = true;
        source = ./sway-config;
        target = "sway/config";
      };

      xdg.configFile."sway-background" = {
        enable = true;
        source = ../../_assets/salty_mountains.png;
        target = "backgrounds/salty_mountains.png";
      };

      xdg.configFile."swayrbar" = {
        enable = true;
        source = ./swayrbar-config.toml;
        target = "swayrbar/config.toml";
      };

      home.packages = with pkgs; [
        sway-contrib.grimshot
        swayrbar
      ];
    };
}

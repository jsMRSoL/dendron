{
  flake.homeModules.clipboard =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wofi
      ];

      xdg.configFile."wofi-config" = {
        enable = true;
        source = ./wofi/config;
        target = "wofi/config";
      };

      xdg.configFile."wofi-css" = {
        enable = true;
        source = ./wofi/style.css;
        target = "wofi/style.css";
      };
    };
}

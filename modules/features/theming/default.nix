{
  flake.homeModules.theming =
    { pkgs, config, ... }:
    {
      gtk.enable = true;

      gtk.theme.package = pkgs.catppuccin-gtk;
      gtk.theme.name = "catppuccin-gtk";
      gtk.gtk4.theme = config.gtk.theme;

      qt = {
        enable = true;
        style = {
          name = "catppuccin-qt5ct";
          package = pkgs.catppuccin-qt5ct;
        };
      };
    };
}

{ self, ... }:
{
  flake.homeModules.udiskie = { pkgs, ... }: {
    home.packages = [
      pkgs.udiskie
      pkgs.udisks2
      pkgs.xdg-utils
    ];

    # Not necessary with noctalia plugin
    # services.udiskie = {
    #   enable = true;
    # };
  };
}

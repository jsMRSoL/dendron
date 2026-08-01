{ self, inputs, ... }: {
  flake.nixosModules.hyprland =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        libsForQt5.qt5ct
        qt6Packages.qt6ct
      ];
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
        systemd.setPath.enable = true;
      };
    };
}

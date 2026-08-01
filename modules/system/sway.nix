{ self, inputs, ... }: {
  flake.nixosModules.sway =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mako # notification system developed by swaywm maintainer
        wshowkeys
      ];

      programs.sway = {
        enable = true;
        xwayland.enable = true;
      };

      programs.wshowkeys.enable = true;
    };
}

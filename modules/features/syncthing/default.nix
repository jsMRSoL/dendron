{
  flake.homeModules.syncthing =
    { pkgs, osConfig, ... }:
    let
      currentSystem = osConfig.networking.hostName;
      configPath = ./. + "/${currentSystem}-config.xml";
      targetPath = ".local/state/syncthing/config.xml";
    in
    {
      services.syncthing.enable = true;

      systemd.user.services.syncthing.Service = {
        ExecStartPre = pkgs.writeShellScript "link-syncthing-config.sh" ''
          if [[ ! -f "$HOME/${targetPath}" ]]; then
            ln -sT ${configPath} "$HOME/${targetPath}"
            echo "''$(date): wrote config from nix config" > "$HOME/.local/state/syncthing/nix.log"
          else
            echo "''$(date): found existing config.xml." > "$HOME/.local/state/syncthing/nix.log"
          fi
        '';
      };
    };
}

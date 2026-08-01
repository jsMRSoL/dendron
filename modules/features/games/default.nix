{
  flake.homeModules.games =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        pingus
        supertux
      ];
    };
}

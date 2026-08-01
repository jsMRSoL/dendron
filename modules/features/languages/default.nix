{
  flake.homeModules.languages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # rust
        rustup
        gcc
        # go
        go
        python3
        # python312Full
        # virtualenv
      ];
      programs.go = {
        enable = true;
        env = {
          goPath = ".go";
          goBin = ".go/bin";
        };
      };
    };
}

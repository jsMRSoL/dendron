{
  flake.homeModules.yazi =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        shellWrapperName = "yy";
      };

      xdg.configFile."yazi-configs" = {
        enable = true;
        source = ./yazi;
        target = "yazi";
      };

      # plugin dependencies
      home.packages = with pkgs; [
        catdoc
        python312Packages.docx2txt
        python312Packages.xlsx2csv
        odt2txt
      ];
    };
}

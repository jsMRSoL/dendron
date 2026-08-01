{
  flake.homeModules.atuin = {
    programs.atuin = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        search_mode = "fuzzy";
        style = "full";
        inline_height = 20;
        invert = true;
        enter_accept = true;
      };
    };
  };
}

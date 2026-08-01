{
  flake.homeModules.git = {
    programs.git = {
      enable = true;
      signing.format = "openpgp";
      settings = {
        user = {
          name = "Simon Pitt";
          email = "si_pitt@yahoo.com";
        };
        pull.rebase = true;
        rebase.autostash = true;
      };
    };
  };
}

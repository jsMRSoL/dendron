{
  flake.nixosModules.postgresql =  {
    services.postgresql = {
      enable = true;
      enableJIT = true;
      ensureDatabases = [
        "simon"
      ];
      ensureUsers = [
        {
          name = "simon";
          ensureDBOwnership = true;
        }
      ];
      initdbArgs = [
        "--locale=C.UTF-8"
        "--encoding=UTF8"
        "--data-checksums"
      ];
    };
  };
}

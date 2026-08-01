{
  flake.homeModules.scripts = {
    imports = [
      ./_docx2clean.nix
      ./_sxiv-handler.nix
      ./_ocrscripts.nix
      ./_deps2nix.nix
    ];
  };
}

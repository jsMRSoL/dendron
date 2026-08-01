{ pkgs, ... }:
let
  docx2clean = pkgs.writeShellScriptBin "docx2clean" ''
    docx2txt "$1" | sed '/^[[:space:]]*$/d'
  '';
in
{
  home.packages = [
    docx2clean
  ];
}

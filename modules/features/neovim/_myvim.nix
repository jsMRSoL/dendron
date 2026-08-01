{ pkgs, ... }:
let
  my-name = "myvim";
  my-script = pkgs.writeShellScriptBin my-name ''
    NVIM_APPNAME=MyVim nvim $@	
  '';
  my-buildInputs = with pkgs; [
    neovim
    # go packages
    impl
    gomodifytags
    iferr
    golines # fixes long lines
    gotests # test generator
    gotestsum # test runner
    delve # debugger, bin is dlv
    # rust packages are installed via rustup
    # python
    pyright # ? or pylsp
    python312Packages.debugpy
    # js / ts
    prettierd
    typescript # provides tsserver
    # lua
    lua-language-server
    # shell
    shfmt
    shellcheck
    beautysh
  ];
in

pkgs.symlinkJoin {
  name = my-name;
  paths = [ my-script ] ++ my-buildInputs;
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";
}

{
  flake.homeModules.emacs =
    { config, pkgs, ... }:
    let
      link = config.lib.file.mkOutOfStoreSymlink;

      deps = [
        pkgs.libtool
        pkgs.cmake
      ];

      simacs = pkgs.symlinkJoin {
        name = "emacs-wrapper";
        paths = [ pkgs.emacs ] ++ deps;
      };
    in
    {
      home.packages = with pkgs; [
        # emacs
        simacs
        emacs-all-the-icons-fonts
      ];

      # use an absolute path. Otherwise link will point to subtree in nix store.
      home.file = {
        ".emacs.d/early-init.el".source = link /home/simon/.nixos/modules/features/emacs/early-init.el;
        ".emacs.d/simacs.org".source = link /home/simon/.nixos/modules/features/emacs/simacs.org;
      };
    };
}

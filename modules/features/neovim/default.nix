{
  flake.homeModules.neovim =
    { config, pkgs, ... }: {
      programs.neovim = {
	enable = true;
	sideloadInitLua = true;
	withPython3 = true;
	withRuby = false;
      };

      home.file.".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink /home/simon/.nixos/modules/features/neovim/nvim;

      home.packages = with pkgs; [
        nixd
        nixfmt
        lua-language-server
        pyright
        shfmt
        shellcheck
      ];
    };
}

{ self, inputs, ... }: {

  # This is your module that imports and configures home-manager
  flake.nixosModules.homeManagerSimon = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      # https://nix-community.github.io/home-manager/options/nixos/index.html
      useUserPackages = true;
      backupFileExtension = "backup";
      users.simon = {
        home = {
          username = "simon";
          homeDirectory = "/home/simon";
          stateVersion = "26.05";
          packages = [ ];
        };

        imports = [
          self.homeModules.atuin
          self.homeModules.bash
          self.homeModules.clipboard
          self.homeModules.emacs
          self.homeModules.foot
          self.homeModules.games
          self.homeModules.git
          self.homeModules.hyprland
          self.homeModules.kitty
          self.homeModules.languages
          self.homeModules.neovim
          self.homeModules.noctalia
          self.homeModules.scripts
          self.homeModules.syncthing
          self.homeModules.theming
          self.homeModules.tmux
          self.homeModules.tmuxScripts
          self.homeModules.udiskie
          self.homeModules.whisper
          self.homeModules.yazi
        ];
      };
    };
  };

}

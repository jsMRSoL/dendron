{ self, inputs, ... }: {

  # This is your module that imports and configures home-manager
  flake.nixosModules.homeManagerSimon = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useUserPackages = true;
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
          self.homeModules.dunst
          self.homeModules.emacs
          self.homeModules.foot
          self.homeModules.games
          self.homeModules.git
          self.homeModules.hyprland
          self.homeModules.languages
          self.homeModules.neovim
          self.homeModules.scripts
          self.homeModules.syncthing
          self.homeModules.theming
          self.homeModules.tmux
          self.homeModules.tmuxScripts
          self.homeModules.waybar
          self.homeModules.whisper
          self.homeModules.yazi
        ];
      };
    };
  };

}

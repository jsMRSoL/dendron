{ self, inputs, ... }:
{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    let
      sddm-astronaut' = pkgs.sddm-astronaut.override {
        themeConfig = {
          background = "${../../_assets/nix-wallpaper-catppuccin_dark.png}";
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          Font = "Open Sans";
          DimBackground = "0.0";
          HeaderTextColor = "#a6adc8";
          DateTextColor = "#a6adc8";
          TimeTextColor = "#a6adc8";
          FormBackgroundColor = "#45475a";
          BackgroundColor = "#45475a";
          DimBackgroundColor = "#45475a";
          LoginFieldBackgroundColor = "#313244";
          PasswordFieldBackgroundColor = "#313244";
          LoginFieldTextColor = "#a6adc8";
          PasswordFieldTextColor = "#a6adc8";
          UserIconColor = "#a6adc8";
          PasswordIconColor = "#a6adc8";
          PlaceholderTextColor = "#7c6f64";
          WarningColor = "#a6adc8";
          LoginButtonTextColor = "#ffffff";
          LoginButtonBackgroundColor = "#a6adc8";
          SystemButtonsIconsColor = "#a6adc8";
          SessionButtonTextColor = "#a6adc8";
          VirtualKeyboardButtonTextColor = "#a6adc8";
          DropdownTextColor = "#ffffff";
          DropdownSelectedBackgroundColor = "#7c6f64";
          DropdownBackgroundColor = "#a6adc8";
          HighlightTextColor = "#7c6f64";
          HighlightBackgroundColor = "#a6adc8";
          HighlightBorderColor = "transparent";
          HoverUserIconColor = "#7c6f64";
          HoverPasswordIconColor = "#7c6f64";
          HoverSystemButtonsIconsColor = "#7c6f64";
          HoverSessionButtonTextColor = "#7c6f64";
          HoverVirtualKeyboardButtonTextColor = "#7c6f64";
        };
        embeddedTheme = "japanese_aesthetic";
      };
    in
    {
      environment.systemPackages = [
        sddm-astronaut'
      ];

      services.displayManager = {
        sddm = {
          enable = true;
          theme = "sddm-astronaut-theme"; # elarun, maldives, maya
          wayland.enable = true;
          extraPackages = [ pkgs.kdePackages.qtmultimedia ];
        };
      };

      security.polkit.enable = true;
    };
}

{ lib, ... }: {
  options.flake.hostConfigs = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          termFontSize = lib.mkOption {
            type = lib.types.ints.positive;
            default = 12;
            description = "Terminal font size.";
          };

          keyboardType = lib.mkOption {
            type = lib.types.str;
            default = "at-translated-set-2-keyboard";
            description = "Keyboard type.";
          };
        };
      }
    );

    default = { };
  };

  config.flake.hostConfigs = {
    # these use the defaults
    swingvm = { };
    nirivm = { };

    viv = {
      termFontSize = 16;
    };

    derek = {
      termFontSize = 14;
      keyboardType = "usb-hid-keyboard";
    };
  };
}

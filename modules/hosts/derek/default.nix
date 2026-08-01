{ self, inputs, ... }: {
  flake.nixosConfigurations.derek = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.bluetooth
      self.nixosModules.coreSettings
      self.nixosModules.garbageCollection
      self.nixosModules.hyprland
      self.nixosModules.nfs
      self.nixosModules.sddm
      self.nixosModules.sound
      self.nixosModules.systemdBoot
      self.nixosModules.wayland
      self.nixosModules.derekConfiguration
      self.nixosModules.homeManagerSimon
    ];
  };

  flake.nixosModules.derekConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.derekHardware
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      i2c = {
        enable = true;
      };
    };

    networking.hostName = "derek"; # Define your hostname.

    users.users.simon.extraGroups = [
      "i2c"
      "libvirtd"
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    environment.systemPackages = [ ];

    system.stateVersion = "26.05"; # Never ever change this. Ever.
  };

  flake.nixosModules.derekHardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [
        "kvm-amd"
        "i2c-dev"
        "ddcci_backlight"
      ];
      boot.kernelParams = [
        "acpi_backlight=video"
      ];
      boot.extraModulePackages = [ ];
      services.udev.extraRules = ''
        KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
      '';

      fileSystems."/" = {
        # device = "/dev/disk/by-uuid/80999860-daad-478c-960c-81b7c1770d14";
        device = "/dev/disk/by-partlabel/NIXOS";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        # device = "/dev/disk/by-uuid/46F2-52AD";
        device = "/dev/disk/by-partlabel/BOOT";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/mnt/data" = {
        device = "/dev/disk/by-partlabel/DATA";
        fsType = "ext4";
      };

      fileSystems."/home/simon/Documents" = {
        depends = [
          "/home/simon"
          "/mnt/data"
        ];
        device = "/mnt/data/Documents";
        fsType = "ext4";
        options = [ "bind" ];
      };

      fileSystems."/home/simon/Downloads" = {
        depends = [
          "/home/simon"
          "/mnt/data"
        ];
        device = "/mnt/data/Downloads";
        fsType = "ext4";
        options = [ "bind" ];
      };

      fileSystems."/home/simon/Music" = {
        depends = [
          "/home/simon"
          "/mnt/data"
        ];
        device = "/mnt/data/Music";
        fsType = "ext4";
        options = [ "bind" ];
      };

      fileSystems."/home/simon/Pictures" = {
        depends = [
          "/home/simon"
          "/mnt/data"
        ];
        device = "/mnt/data/Pictures";
        fsType = "ext4";
        options = [ "bind" ];
      };

      fileSystems."/home/simon/Projects" = {
        depends = [
          "/home/simon"
          "/mnt/data"
        ];
        device = "/mnt/data/Projects";
        fsType = "ext4";
        options = [ "bind" ];
      };

      fileSystems."/home/simon/Videos" = {
        depends = [
          "/home/simon"
          "/mnt/data"
        ];
        device = "/mnt/data/Videos";
        fsType = "ext4";
        options = [ "bind" ];
      };

      swapDevices = [
        { device = "/dev/disk/by-partlabel/SWAP"; }
      ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}

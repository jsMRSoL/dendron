{ self, inputs, ... }: {
  flake.nixosConfigurations.nirivm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.bluetooth
      self.nixosModules.coreSettings
      self.nixosModules.garbageCollection
      self.nixosModules.nfs
      self.nixosModules.sddm
      self.nixosModules.sound
      self.nixosModules.sway
      self.nixosModules.systemdBoot
      self.nixosModules.wayland
      self.nixosModules.nirivmConfiguration
      self.nixosModules.homeManagerSimon
    ];
  };

  flake.nixosModules.nirivmConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.nirivmHardware
    ];

    networking.hostName = "nirivm"; # Define your hostname.

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;

    system.stateVersion = "26.05"; # Never ever change this. Ever.
  };

  flake.nixosModules.nirivmHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

      boot.initrd.availableKernelModules = [
        "ahci"
        "xhci_pci"
        "virtio_pci"
        "sr_mod"
        "virtio_blk"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-partlabel/nixos";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-partlabel/ESP";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-partlabel/swap"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}

{
  flake.nixosModules.nfs = {
    # enable necessary NFS utilities for client
    boot.supportedFilesystems = [ "nfs" ];
  };
}

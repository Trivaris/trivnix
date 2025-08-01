{
  disko.devices.disk.nixos = {
    type = "disk";
    device = "/dev/nvme0n1";
    content.type = "gpt";

    content.partitions = {
      boot = {
        size = "512M";
        type = "EF00";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          extraArgs = [ "-F32" ];
          mountOptions = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      root = {
        size = "100%";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
        };
      };

      swap = {
        size = "16G";
        content = {
          type = "swap";
          randomEncryption = true;
          priority = 100;
        };
      };
    };
  };
}

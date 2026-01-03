{
  disko.devices = {
    disk = {
      sda3 = {
        type = "disk";
        device = "/dev/sda3";
        content = {
          type = "gpt";
          partitions = {
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-L"
                  "Data"
                  "-f"
                ]; # Override existing partition
                mountpoint = "/data";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}

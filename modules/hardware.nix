{ pkgs
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.kernelPackages = pkgs.unstable.linuxKernel.packages.linux_zen;

  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
    HandleLidSwitch=ignore
  '';

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
  '';

  home-manager.users.olga.dconf.settings = {
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "hibernate";
      sleep-inactive-battery-timeout = 45 * 60;
      sleep-inactive-battery-type = "hibernate";
      sleep-inactive-ac-type = "nothing";
    };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
      rocmPackages.rocm-runtime
    ];
  };

  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    radeontop
  ];

  boot.kernelParams = [
    "video=eDP-1:2880x1800@120"
  ];

  services.lvm.boot.thin.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3df291b6-2407-45ab-baa3-bfa785930ad7";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/3df291b6-2407-45ab-baa3-bfa785930ad7";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/3df291b6-2407-45ab-baa3-bfa785930ad7";
    fsType = "btrfs";
    options = [ "subvol=@logs" "compress=zstd" ];
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/3df291b6-2407-45ab-baa3-bfa785930ad7";
    fsType = "btrfs";
    options = [ "subvol=@cache" "compress=zstd" ];
  };

  fileSystems."/var/tmp" = {
    device = "/dev/disk/by-uuid/3df291b6-2407-45ab-baa3-bfa785930ad7";
    fsType = "btrfs";
    options = [ "subvol=@tmp" "compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A0DB-778D";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/win" = {
    device = "/dev/disk/by-uuid/604CDFDD4CDFABD2";
    fsType = "ntfs";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/10567f6d-48de-4dd4-b2f0-cf7747098714"; }
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}

{ inputs, ... }: {
  imports = [
    ./apps.nix
    ./desktop.nix
    ./firefox.nix
    ./fonts.nix
    ./hardware.nix
    ./home.nix
    ./python.nix
    ./rust.nix
    ./sboot.nix
    ./shell.nix
    ./unfree.nix
    ./users.nix
    ./vscode.nix
  ];

  nixpkgs.overlays =
    let
      overlay-unstable = final: prev: {
        unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
      };
    in
    [ inputs.nur.overlay overlay-unstable ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.snapper.configs = {
    home = {
      SUBVOLUME = "/home";
      ALLOW_USERS = [ "olga" ];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
    };
  };

  networking.hostName = "capybara";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  boot = {
    plymouth.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    loader.timeout = 0;
  };

  system.stateVersion = "24.05";
}

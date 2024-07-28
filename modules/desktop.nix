{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    xkb.layout = "ru,us";
    xkb.options = "grp:win_space_toggle";
  };
  services.displayManager.autoLogin.user = "olga";

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-connections
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      epiphany
      gnome-maps
      gnome-music
    ]);

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    # NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    gnome3.dconf-editor
  ];

  home-manager.users.olga.dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${../wallpaper.jpg}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-seconds = true;
      show-battery-percentage = true;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
  };
}

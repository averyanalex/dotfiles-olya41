{ pkgs, ... }: {
  home-manager.users.olga.home.packages = with pkgs; [
    cargo
    rustc
  ];
}

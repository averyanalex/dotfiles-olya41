{ inputs, ... }: {
  imports = [ inputs.home-manager.nixosModule ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.olga = {
      programs.home-manager.enable = true;
      home.stateVersion = "24.05";
      home.username = "olga";
      home.homeDirectory = "/home/olga";
    };
  };
}

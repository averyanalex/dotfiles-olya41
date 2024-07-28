{
  users = {
    mutableUsers = false;
    users.olga = {
      description = "Карасева Ольга";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "6745";
      createHome = true;
      uid = 1000;
    };
  };
}

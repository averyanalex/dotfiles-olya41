{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      jetbrains-mono
      meslo-lgs-nf
      monaspace
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "MesloLGS NF" ];
      };
    };
  };
}

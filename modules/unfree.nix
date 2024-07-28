{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
      "corefonts"
      "vscode-extension-ms-vscode-cpptools"
      "geogebra"
      "obsidian"
    ];
}

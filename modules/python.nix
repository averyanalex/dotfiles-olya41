{ pkgs, ... }: {
  home-manager.users.olga.home.packages = [
    (pkgs.python3.withPackages
      (ps: [
        ps.jupyter
        ps.ipython

        ps.ipympl
        ps.matplotlib
        ps.seaborn

        ps.numpy
        ps.pandas
        ps.tqdm

        ps.mypy
        ps.numba
      ]))
  ];
}

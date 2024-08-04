{ pkgs, ... }: {
  home-manager.users.olga.home.packages = [
    (pkgs.python3.withPackages
      (ps: [
        ps.astropy
        ps.ipympl
        ps.ipython
        ps.jupyter
        ps.matplotlib
        ps.mypy
        ps.numba
        ps.numpy
        ps.pandas
        ps.scikit-learn
        ps.scipy
        ps.seaborn
        ps.sympy
        ps.tqdm
      ]))
  ];
}

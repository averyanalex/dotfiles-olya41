{ pkgs
, lib
, ...
}: {
  home-manager.users.olga = {
    home.packages = with pkgs; [
      smartmontools
      nixpkgs-fmt
      btop
      ripgrep
      ripgrep-all
      compsize
    ];

    programs.micro.enable = true;

    home.sessionVariables = {
      EDITOR = "micro";
    };

    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "Olya41";
      userEmail = "olga.experiment@mail.ru";

      extraConfig = {
        core.editor = "micro";
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.eza.enable = true;
    programs.bat.enable = true;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;

      nix-direnv.enable = true;
    };

    programs.bash = {
      enable = true;
      initExtra = ''
        if [[ "$(tty)" != /dev/tty* && $(ps --no-header --pid=$PPID --format=comm) != "zsh" && -z $BASH_EXECUTION_STRING ]]; then
          exec zsh
        fi
      '';
    };

    programs.zsh = {
      enable = true;

      history = {
        size = 30000;
        save = 30000;
        extended = true;
        path = "/home/olga/.local/state/zsh/history";
      };

      dotDir = ".config/zsh";
      autosuggestion.enable = true;
      enableCompletion = true;
      autocd = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "zsh-interactive-cd"
          "git-auto-fetch"
          "git"
        ];
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./p10k-config;
          file = "p10k.zsh";
        }
      ];

      shellAliases = {
        cd = "z";
        ls = "eza --icons -l";
        la = "eza --icons -la";
        lt = "eza --icons --tree";
        ip = "ip --color=auto";
        upd = "sudo nixos-rebuild switch --flake .";
      };
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];
}

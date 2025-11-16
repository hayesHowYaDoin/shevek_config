{
  pkgs,
  user,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
    image = ../assets/dolomites2.jpg;
  };

  features = {
    cli = {
      git = {
        enable = true;
        userName = user.gitUser;
        userEmail = user.gitEmail;
      };
      nvim = {
        enable = true;
        theme = {
          name = "gruvbox-material";
          style = "dark-medium";
        };
      };
      zsh.enable = true;
    };
    desktop = {
      fonts.enable = true;
      applications = {
        ghostty = {
          enable = true;
          opacity = 0.8;
          shader = ../assets/cursor_tail.glsl;
          windowDecoration = false;
        };
        obsidian.enable = true;
      };
      environments = {
        gnome.enable = true;
      };
    };
  };

  home = {
    username = user.name;
    homeDirectory = user.home;
    stateVersion = "24.11";
    packages = with pkgs; [
      spotify
      godot_4
      discord
    ];
  };

  # Stylix can't replace this file and deleting it has no obvious concequence
  #  home.activation.removeBackups = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
  #    rm -f ${config.home.homeDirectory}/.gtkrc-2.0
  #    rm -f ${config.home.homeDirectory}/.config/user-dirs.dirs
  #  '';

  programs.home-manager.enable = true;
}

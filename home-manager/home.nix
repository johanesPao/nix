{ config, pkgs, specialArgs, lib, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = specialArgs.allowUnfree or false;
      allowUnfreePredicate = specialArgs.allowUnfreePredicate or (x: false);
    };
  };
  # # Profile pengguna home-manager
  home.username = specialArgs.pengguna;
  home.homeDirectory = specialArgs.direktori_pengguna;

  # # Nilai ini menentukan rilis dari home-manager yang kompatibel dengan konfigurasi.
  # # Hal ini untuk mencegah terjadinya kerusakan jika versi baru dari home-manager
  # # memperkenalkan perubahan yang tidak backward-compatible
  # 
  # # Jangan ubah nilai ini sekalipun kita mengupdate home-manager.
  home.stateVersion = specialArgs.versi; # Please read the comment before changing.

  # font
  fonts.fontconfig.enable = true;

  # # Package - package mendasar yang lebih universal dan tidak terlalu terkait
  # # dengan penggunaan bahasa pemrograman seperti curl, wget, git, gh, fh
  imports = [
    ./aplikasi/package.nix
  ];
i
  # # File association dan default app
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["org.gnome.Evince.dekstop"];
    };
    defaultApplications = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
    };
  };

  # # Pengaturan dotfiles dilakuklan pada bagian ini
  home.file = {
    # # Konfigurasi pada bagian ini akan menciptakan kopi 'dotfiles/screenrc' di
    # # Nix store, pada contoh di bawah akan mengakibatkan '~/.screenrc' sebagai
    # # symlink pada copy-nya di Nix store
    # ".screenrc".source = dotfiles/screenrc;

    # # Atau juga mengisi konten dotfiles sekaligus seperti contoh di bawah ini
    # # yang akan menuliskan pada folder ~/.gradle, file gradle.properties teks
    # # sebagai berikut:
    # # org.gradle.console-verbose
    # # org.gradlle.daemon.idletimeout=3600000
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  xdg.configFile = {
    "alacritty/alacritty.toml".source = ./aplikasi/alacritty/alacritty.toml;
  };

  # # Jika kita menggunakan dan mengelola shell melalui home-manager, maka kita
  # # dapat mendefinisikan variable env dari shell pada home.sessionVariables di
  # # bawah ini.
  # # Jika penggunaan dan pengelolaan shell dilakukan di luar home-manager, maka
  # # variable env dari shell dapat didefinisikan pada file 'hm-session-vars.sh'
  # # yang biasanya terdapat di (source 'hm-session-vars.sh' dilakukan secara
  # # manual):
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # atau
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # atau
  #
  #  /etc/profiles/per-user/jpao/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
  #  EDITOR = "vim";
  };

  # # Enable home-manager dan program - program yang membutuhkan deklarasi konfigurasi
  programs = {
    # #
    # # Enable home-manager
    # #
    home-manager = {
      enable = true;
    };
    # #
    # # Enable bash
    # #
    bash = {
      enable = true;
      shellAliases = {
        isi = "ls -al";
        hms = "home-manager switch --flake ${specialArgs.direktori_dotfiles}/nix#linux_x86_64";
      };
      # # Perubahan pada variabel session di bawah ini memerlukan relogin
      sessionVariables = {
        XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        TERM = "alacritty";
      };
    };
    # #
    # # Enable starship
    # #
    starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };
    # #
    # # Enable neovim
    # #
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        vim-nix
      ];
    };
    # #
    # # Enable direnv dan integrasikan dengan nix-direnv
    # # (https://github.com/nix-community/nix-direnv)
    # #
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}

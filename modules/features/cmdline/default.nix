{
  flake.homeModules.commandline =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        aspell
        aspellDicts.en
        bacon
        bash-preexec
        bat
        clipman
        duf
        exiftool
        fastfetch
        fd
        ffmpeg
        ffmpegthumbnailer
        fzf
        htop
        imagemagick
        lazygit
        ledger
        libnotify
        mediainfo
        mprocs
        mpv
        mupdf
        # neovim
        # nixvim.packages.x86_64-linux.default
        ncdu
        pandoc
        papirus-icon-theme
        pdfannots2json
        ripgrep
        rsync
        sxiv
        tesseract
        trash-cli
        tree
        unar
        unpaper
        unzip
        vim
        visidata
        wakeonlan
        wipe
        xdg-utils
        xrdb
        zip
      ];

      home.file."Xresources" = {
        enable = true;
        source = ./Xresources;
        target = ".Xresources";
      };
    };
}

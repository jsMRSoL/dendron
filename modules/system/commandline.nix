{
  flake.nixosModules.commandline =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
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
        jq
        lazygit
        ledger
        libnotify
        mediainfo
        mprocs
        mpv
        mupdf
        ncdu
        pandoc
        papirus-icon-theme
        pavucontrol
        pdfannots2json
        ripgrep
        rsync
        socat
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

      programs = {
        gpu-screen-recorder.enable = true;
      };
    };
}

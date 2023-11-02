{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    appimage-run
    brave
    cmatrix
    discord
    easyeffects
    gthumb
    gnome.file-roller
    helvum
    htop
    libnotify
    lutris
    onefetch
    onlyoffice-bin
    pcmanfm
    polkit_gnome
    protonup-qt
    spotify
    steam
    swww
    tmux
    tree
    vlc
  ];
}

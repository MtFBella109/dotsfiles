{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Fonts
    apl386
    corefonts
    nerdfonts
    noto-fonts
    dejavu_fonts
    font-awesome
    fira-code-symbols
    powerline-symbols
    material-design-icons
    vistafonts
    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "FiraCode" "JetBrainsMono" "LiberationMono" "SourceCodePro" "Iosevka"];})
  ];
}

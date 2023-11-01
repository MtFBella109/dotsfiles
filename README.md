# dotsfiles

## Installation
1. Copy this git repository with `git clone https://github.com/MtFBella109/dotsfiles`
2. Go into the directory with `cd dotsfiles`
3. Add your User Packages into home/user/dev/packages.nix
4. Make the Script executable with `chmod 733 ./install.sh`
5. Now Execute the Script and follow the Output with `./install.sh`
6. Have fun

## General Infos
If you download it for the first time, you will need a bit to fully understand how the strcuture is, here are some important things
- The Waybar stuff is under home/user/services/wayland/waybar
- Everything from Hyprland is under home/user/graphical/wms/hyprland
- User Packages go in home/user/dev/packages.nix
- the directory dots seems empty, but everything in there is only hidden type `ls -al` to see everything
**If you have any Error's please open a Pull Request and I will check how to fix that**

## Specs
- Distro: NixOS
- WM: Hyprland
- Theme: Adwaita-Dark
- Window-System: Wayland

## Credits 
Thanks to [redyf](https://github.com/redyf) and his [nixdots](https://github.com/redyf/nixdots)

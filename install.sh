#!/usr/bin/env bash

## Install packages temporarily ti gather some Informations
virtualization=$(nix-shell -p virt-what --run 'virt-what')
gpu=$(nix-shell --packages pciutils --run 'lspci | grep -E "VGA|3D"')
## Get the bunch of stuff out ouf the /etc/nixos/configuration.nix
nixos_file="/etc/nixos/configuration.nix"
timezone=$(grep 'time.timeZone =' "$nixos_file" | awk -F'"' '{print $2}')
layout=$(grep 'layout =' "$nixos_file" | awk -F'"' '{print $2}')
locale=$(grep 'i18n.defaultLocale =' "$nixos_file" | awk -F'"' '{print $2}')
format="{:%H:%M}"
pwd=$PWD

## Rename everything to the correct username and change some things in the configuration.nix
sed -i "s/USER/$USER/g" ./flake.nix
sed -i "s/USER/$USER/g" ./home.nix
sed -i "s/USER/$USER/g" ./home/user/home.nix
sed -i "s/USER/$USER/g" ./hosts/user/configuration.nix
sed -i "s/TIMEZONE/$(echo $timezone | sed 's/\//\\\//g')/g" ./hosts/user/configuration.nix
sed -i "s/TIMEZONE/$(echo $timezone | sed 's/\//\\\//g')/g" ./home/user/services/wayland/waybar/config.nix
if [ -z "$layout" ]; then
      layout=us
fi
if [[ $timezone = America* ]]; then
      format="{:%a %b %d}"
      sed -i "s/FORMAT/$format/g" ./home/user/services/wayland/waybar/config.nix
else
      sed -i "s/FORMAT/$format/g" ./home/user/services/wayland/waybar/config.nix
fi
if [ -z $virtualization ]; then
      virtualbox=false
elif [[ $virtualization == *"virtualbox"* ]]; then
      virtualbox=true
else
      virtualbox=false
fi
if echo "$gpu" | grep -i "NVIDIA" > /dev/null; then
      gpu="nvidia"
elif $virtualbox; then
      gpu="virtualbox"
else
      gpu="modesetting"
fi
sed -i "s/LAYOUT/$layout/g" ./hosts/user/configuration.nix
sed -i "s/LOCALE/$locale/g" ./hosts/user/configuration.nix
sed -i "s/DRIVER/$gpu/g" ./hosts/user/configuration.nix
sed -i "s/LAYOUT/$layout/g" ./home/user/graphical/wms/hyprland/default.nix

## Make backups if the directory exists
if test -d $HOME/.config/hypr; then
  mv $HOME/.config/hypr $HOME/.config/hyprbkp
fi
if test -d $USER/.backgrounds; then
  mv $HOME/.backgrounds $HOME/.backgroundsbkp
fi
if test -d $USER/.themes; then
  mv $HOME/.themes $HOME
fi
rm -rf ./.git

## Make everything executable
cd dots
chmod -R 733 ./*
cd ../

## Make a hardlink to the dotfiles, that aren't managed via home-manager
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
ln -s $pwd/dots/config/hypr/autostart /home/$USER/.config/hypr/autostart
ln -s $pwd/dots/config/hypr/scripts /home/$USER/.config/hypr/scripts
ln -s $pwd/dots/config/hypr/store /home/$USER/.config/hypr/store
ln -s $pwd/dots/backgrounds /home/$USER/.backgrounds
ln -s $pwd/dots/config/waybar/scripts /home/$USER/.config/waybar/scripts
ln -s $pwd/dots/config/waybar/store /home/$USER/.config/waybar/store
ln -s $pwd/dots/themes /home/$USER/.themes

## Copy the hardware-configuration.nix
echo "Should we copy the hardware-configuration.nix from /etc/nixos to this directory y/N? (Needed to apply all the configs, this command will need sudo privileges)"
read input
if test "$input" = "y"; then
  echo "We copy now the hardware-configuration.nix"
  sudo cp /etc/nixos/hardware-configuration.nix ./hosts/user/
else
  echo "Okay, we don't copy it, but remember to add it under hosts/$USER or otherwise you can't apply this configs"
fi

## Rename the directory under home and hosts
mv home/user home/$USER
mv hosts/user hosts/$USER

## Actually install everything
echo "Do you want to install this configuration via the Flake y/n?"
read userinput
if test "$userinput" = "y"; then
  echo "We need to execute the next command with sudo, so pleasy type in your Password"
  sudo nixos-rebuild boot --impure --flake .#$USER
else
  echo "Okay, we don't apply the configs, if you want to apply them go in this directory and Type in this Command: 'sudo nixos-rebuild switch --impure --flake .#$USER'"
fi

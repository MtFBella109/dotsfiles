#!/usr/bin/env bash

## Get the bunch of stuff out ouf the /etc/nixos/configuration.nix
nixos_file="/etc/nixos/configuration.nix"
timezone=$(grep 'time.timeZone =' "$nixos_file" | awk -F'"' '{print $2}')
layout=$(grep 'layout =' "$nixos_file" | awk -F'"' '{print $2}')
locale=$(grep 'i18n.defaultLocale =' "$nixos_file" | awk -F'"' '{print $2}')

## Rename everything to the correct username and change some things in the configuration.nix
sed -i "s/USER/$USER/g" ./flake.nix
sed -i "s/USER/$USER/g" ./home/user/home.nix
sed -i "s/USER/$USER/g" ./hosts/user/configuration.nix
sed -i "s/TIMEZONE/$timezone/g" ./hosts/user/configuration.nix
if [ -z "$layout" ]
then
      layout=us
fi
sed -i "s/LAYOUT/$layout/g" ./hosts/user/configuration.nix
sed -i "s/LOCALE/$locale/g" ./hosts/user/configuration.nix

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

## Make a symlink to the dotfiles, that aren't managed via home-manager
ln -s ./dots/.config/hypr/autostart $HOME/.config/hypr/autostart
ln -s ./dots/.config/hypr/scripts $HOME/.config/hypr/scripts
ln -s ./dots/.config/hypr/store $HOME/.config/hypr/store
ln -s ./dots/.backgrounds $HOME/.backgrounds
ln -s ./dots/.themes $HOME/.themes

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
  sudo nixos-rebuild switch --impure --flake .#$USER
else
  echo "Okay, we don't apply the configs, if you want to apply them go in this directory and Type in this Command: 'sudo nixos-rebuild switch --impure --flake .#$USER'"
fi

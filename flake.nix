{
  description = "Redyf's NixOS config for desktop and laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    hyprland-nvidia.url = "github:hyprwm/hyprland";
    waybar-hyprland.url = "github:hyprwm/hyprland";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";

    # SFMono w/ patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    hyprland-nvidia,
    home-manager,
    utils,
    ...
  } @ inputs: {
    nixosConfigurations = {
      USER =
        nixpkgs.lib.nixosSystem
        {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              hyprland-nvidia
              ;
          };
          modules = [
            ./hosts/USER/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = {inherit inputs;};
                users.USER = ./home/USER/home.nix;
              };
            }
            hyprland-nvidia.nixosModules.default
            {programs.hyprland.enable = true;}
          ];
        };
       };
      };
      }

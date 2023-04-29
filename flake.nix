{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      hp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hp-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rob = import ./home-manager/home-sway.nix;
            home-manager.sharedModules = [
              ({ pkgs, ... }: {
                home.packages = with pkgs; [
                  nextcloud-client
                  thunderbird
                  betterlockscreen
                  signal-desktop
                  flameshot
                  prusa-slicer
                  freecad
                  element-desktop
                  android-tools
                ];
              })

              ({ programs.git.userEmail = "robert.rose@mailbox.org"; })
            ];
          }
        ];
      };
    };
  };
}

{
  description = "NixOS configuration files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      hp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hp-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rob = import ./home-manager;
            home-manager.sharedModules = [
              ./home-manager/hp-home.nix
              ./home-manager/nextcloud-client.nix
            ];
          }
        ];
      };
      t14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/t14-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rob = import ./home-manager;
            home-manager.sharedModules = [
              ./home-manager/t14-home.nix
            ];
          }
        ];
      };
    };
  };
}

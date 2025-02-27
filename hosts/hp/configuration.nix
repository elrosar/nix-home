{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  networking = {
    hostName = "hp";
    hosts = {
      "192.168.50.155" = [
        "nextcloud.dev.internal"
        "auth.dev.internal"
        "dashboard.dev.internal"
      ];
    };
  };

  users.users.rob.extraGroups = [
    "dialout"
    "scanner"
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../rob/hp.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}

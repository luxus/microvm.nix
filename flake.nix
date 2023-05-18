{
  description = "NixOS in MicroVMs";
{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixpkgs.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
    outputs = inputs@{ self, haumea, nixpkgs, microvm, ... }:
    let
      inherit (nixpkgs.lib) genAttrs nixosSystem systems;

      system = "x86_64-linux";
      module = { pkgs, ... }@args: haumea.lib.load {
        src = ./src;
        inputs = args // {
          inherit inputs;
        };
        transformer = haumea.lib.transformers.liftDefault;
      };
    in
    {
      defaultPackage.${system} = self.packages.${system}.my-microvm;
      packages.${system}.my-microvm =
        let
          inherit (self.nixosConfigurations.my-microvm) config;
          # quickly build with another hypervisor if this MicroVM is built as a package
          hypervisor = "cloud-hypervisor";
        in config.microvm.runner.${hypervisor};

      nixosConfigurations.cecile = nixosSystem {
        system = "x86_64-linux";
        modules = [
          module
          ./hardware-configuration.nix
          # Include the microvm module
          microvm.nixosModules.microvm
          # Add more modules here
          { }
        ];
      };
      nixosConfigurations.my-microvm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          microvm.nixosModules.microvm
          {
            networking.hostName = "my-microvm";
            users.users.root.password = "";
            microvm = {
              volumes = [ {
                mountPoint = "/var";
                image = "var.img";
                size = 256;
              } ];
              shares = [ {
                # use "virtiofs" for MicroVMs that are started by systemd
                proto = "virtiofs";
                tag = "ro-store";
                # a host's /nix/store will be picked up so that the
                # size of the /dev/vda can be reduced.
                source = "/nix/store";
                mountPoint = "/nix/.ro-store";
              } ];
              socket = "control.socket";
              # relevant for delarative MicroVM management
              hypervisor = "cloud-hypervisor";
            };
          }
        ];
      };
    };
}

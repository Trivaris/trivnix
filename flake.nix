{
  description = ''
    Trivaris' NixOS Config.
  '';

  inputs = {
    # Core Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Nix Community Modules
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Yeshey/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium = {
      url = "git+https://github.com/SteamClientHomebrew/Millennium";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Private Information
    trivnix-private = {
     url = "git+ssh://git@github.com/trivaris/trivnix-private";
    };

    # Non Flake Inputs
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    appflowy = {
      url = "github:AppFlowy-IO/AppFlowy-Cloud";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, ... }:
    import ./outputs.nix { inherit inputs self; };
}

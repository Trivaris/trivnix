{ 
  config, 
  ... 
}: { 
  
  imports = [
    ../common
    ./home.nix
    ./credentials.nix
    ./dotfiles
    ./theme.nix
  ];

}
{ 
  config, 
  ... 
}: { 
  
  imports = [
    ../common
    ./home.nix
    ./credentials.nix
    ./dotfiles
  ];

}
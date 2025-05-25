{ 
  config, 
  ... 
}: { 
  
  imports = [
    ../common
    ../features/cli
    ./home.nix
  ]; 

}
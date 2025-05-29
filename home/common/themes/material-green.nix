{
  inputs,
  ...
}: {

  default = builtins.fromJSON (builtins.readFile (inputs.self + "/common/themes/material-green.json"));
  
}
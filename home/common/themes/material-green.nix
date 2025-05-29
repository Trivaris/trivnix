{
  inputs,
  ...
}: let 
  json = builtins.readFile (inputs.self + "/resources/material-green.json");
in builts.fromJSON json
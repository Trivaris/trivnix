{
  config,
  lib,
  ...
}:
let
  cfg = config.nixosConfig;
in
with lib;
{
  options.nixosConfig.codeServer = import ./config.nix lib;
  
  config = mkIf (cfg.codeServer.enable) {
    services.code-server = {
      enable = true;
      port = cfg.codeServer.port;
      host = cfg.codeServer.ipAddress;
      user = "trivaris";
      hashedPassword = "$argon2i$v=19$m=4096,t=3,p=1$VERtWDdiZFhGZk11Y044Sm53NllKdXVQZ3VVPQ$c9o3xk7W5ecGG1H6pgAkcUFtwmJloR2Cz42RooSb/BI";
    };
  };
}

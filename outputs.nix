{ inputs, self }:
let
  outputs = self.outputs;
  configurations = import ./configurations;
  libExtra = import ./libExtra { inherit inputs outputs; };
in
{
  overlays = import (libExtra.mkFlakePath /overlays) inputs;

  # Define NixOS configurations for each host
  # Format: configname = <NixOS config>
  nixosConfigurations = builtins.mapAttrs (
    configname: rawHost:
    let
      userconfigs = rawHost.users or {};
      hostconfig = rawHost // {
        users = builtins.attrNames userconfigs;
      };
      hosts = builtins.mapAttrs(_: host:
        host // {
          users = builtins.attrNames (host.users or {});
        }
      ) configurations;
    in
    libExtra.mkNixOSConfiguration {
      inherit
        libExtra
        configname
        hostconfig
        userconfigs
        hosts;
    }
  ) configurations;

  # Define Home Manager configurations for each user@hostname
  # Format: <user>@<hostname> (configname) = <Home Manager config>
  homeConfigurations = with inputs.nixpkgs.lib;
  builtins.listToAttrs (
    concatMap (configname:
      let
        rawHost = configurations.${configname};
        userconfigs = rawHost.users or {};
        hostconfig = rawHost // { users = builtins.attrNames userconfigs; };
        hosts = builtins.mapAttrs(_: host:
          host // {
            users = builtins.attrNames (host.users or {});
          }
        ) configurations;
      in
        map (username: {
          name = "${username}@${configname}";
          value = libExtra.mkHomeConfiguration {
            inherit
              libExtra
              userconfigs
              configname
              hostconfig
              hosts;
            userconfig = userconfigs.${username} // { name = username; };
          };
        }) (builtins.attrNames userconfigs)
    ) (builtins.attrNames configurations)
  );
}

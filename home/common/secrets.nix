{
  lib,
  trivnixLib,
  userInfos,
  hostInfos,
  ...
}:
let
  commonSecrets = trivnixLib.mkStorePath "secrets/home/${userInfos.name}/common.yaml";
  hostSecrets = trivnixLib.mkStorePath "secrets/home/${userInfos.name}/${hostInfos.configname}.yaml";

  mkKey = name: {
    ${name} = {
      sopsFile = hostSecrets;
      mode = "0600";
    };
  };
in
{
  sops = {
    defaultSopsFile = commonSecrets;
    validateSopsFiles = true;

    age.keyFile = "/home/${userInfos.name}/.config/sops/age/key.txt";
    age.generateKey = false;

    secrets = lib.mkMerge (
      if hostInfos.hardwareKey then
        [
          (mkKey "ssh-private-key-a")
          (mkKey "ssh-private-key-c")
        ]
      else
        [ (mkKey "ssh-private-key") ]
    );
  };
}

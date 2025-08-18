{
  lib,
  userInfos,
  allHostPrefs,
  allHostInfos,
  ...
}:
let
  aliases = builtins.listToAttrs (
    lib.concatMap (
      configname:
      let
        infos = allHostInfos.${configname};
      in
      [
        {
          name = infos.name;
          value = {
            hostname = infos.ip;
            user = userInfos.name;
          };
        }
      ]
    ) (lib.attrNames (lib.filterAttrs (_: prefs: prefs.openssh.enable or false) allHostPrefs))
  );
in
{

  programs.ssh = {
    enable = true;
    addKeysToAgent = "no";

    matchBlocks = {
      "*" = {
        identitiesOnly = true;
      };
    }
    // aliases;
  };

}

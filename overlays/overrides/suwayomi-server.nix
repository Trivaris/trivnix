{ pkgs, ... }:
let
  jdk = pkgs.jdk21_headless;
in rec {
  revision = null;
  version = "v2.0.1854";

  src = pkgs.fetchurl {
    url = "https://github.com/Suwayomi/Suwayomi-Server-preview/releases/download/${version}/Suwayomi-Server-${version}.jar";
    hash = "sha256-oDE0b77qxTovZTd+P9J01wNxYZ3BrNqoX03biei03pM=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;

  buildPhase = ''
    runHook preBuild

    makeWrapper ${jdk}/bin/java $out/bin/tachidesk-server \
      --add-flags "-Dsuwayomi.tachidesk.config.server.initialOpenInBrowserEnabled=false -jar $src"

    runHook postBuild
  '';
}

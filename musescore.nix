{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    let
      app = appimageTools.wrapType2 {
        pname = "musescore";
        version = "4.7.1";
        src = fetchurl {
          url = "https://cdn.jsdelivr.net/musescore/v4.7.1/MuseScore-Studio-4.7.1.260518142-x86_64.AppImage";
          sha256 = "1jxmb37wqn7k755h20mkb1nnay4ym44jnpsj0qfp02yha23xiyi0";
        };
      };
    in
    [
      app
      (makeDesktopItem {
        name = "musescore";
        desktopName = "MuseScore 4";
        exec = "${app}/bin/musescore";
        icon = "musescore";
        categories = [
          "AudioVideo"
          "Music"
          "Graphics"
        ];
      })
    ];
}

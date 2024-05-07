{pkgs, ...}: let
  flutter = pkgs.fetchzip {
    url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.3-stable.tar.xz";
    hash = "sha256-j+Jl8Q8Qaj9oJVZ1LNuTuIVxX7ba0f8w38OdS/vvqtA=";
  };
  in {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
    ];
    bootstrap = ''
        cp -rf ${./} "$out"
        chmod -R +w "$out"
        rm "$out/idx-template.nix
        rm "$out/idx-template.json
        cp -rf ${flutter} flutter
        chmod -R u+w flutter
        mkdir -p "$out"/.{flutter-sdk,idx}
        mv flutter "$out/.flutter-sdk/flutter"
    '';
}
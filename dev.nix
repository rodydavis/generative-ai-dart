# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodePackages.firebase-tools
    pkgs.jdk17
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];
    # Enable previews and customize configuration
    workspace.onCreate = {
        pub-get = "./.flutter-sdk/flutter/bin/flutter pub get";
    };
    previews = {
      enable = true;
      previews = [
        {
          command = ["./.flutter-sdk/flutter/bin/flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT" "-t" "samples/flutter_app/lib/main.dart"];
          id = "web";
          manager = "flutter";
        }
        {
          command = ["./.flutter-sdk/flutter/bin/flutter" "run" "--machine" "-d" "android" "-d" "localhost:5555" "-t" "samples/flutter_app/lib/main.dart"];
          id = "android";
          manager = "flutter";
        }
      ];
    };
  };
}

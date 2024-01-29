{pkgs, ...}: {
  home.packages = with pkgs;
    [
      cljstyle
      clojure
      coreutils
      fd
      fnm
      google-java-format
      gh
      git
      jdk11_headless
      jq
      kitty
      leiningen
      nodejs
      rbenv
      ruby
      wormhole-william
    ]
    ++ (map ((lib.flip pkgs.callPackage) {}) [
      ./antifennel.nix
      ./caskaydia-cove-nerd-font.nix
      ./jenv.nix
      ./ruby-build.nix
    ]);
}

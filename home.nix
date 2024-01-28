{ pkgs, lib, ... }:

{
  imports = lib.my.directories ./modules;

  home = {
    packages = with pkgs; [
      antifennel
      caskaydia-cove-nerd-font
      cljstyle
      clojure
      coreutils
      fd
      fnm
      gh
      git
      jdk11_headless
      jenv
      jq
      kitty
      leiningen
      nodejs
      rbenv
      ruby
      ruby-build
      wormhole-william
    ];

    file.".editorconfig".source = ./editorconfig;
  };

  xdg.configFile = {
    "stylua/stylua.toml" = {
      enable = true;
      source = ./stylua.toml;
    };
    "nix/nix.conf" = {
      enable = true;
      source = ./nix.conf;
    };
  };
}

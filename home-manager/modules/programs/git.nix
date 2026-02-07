{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      push.autoSetupRemote = true;
      user = {
        name = "Rob Hanlon";
        email = "69870+robhanlon22@users.noreply.github.com";
      };
    };
    maintenance.enable = true;
    signing.signByDefault = true;
  };
}

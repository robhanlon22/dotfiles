{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks."*" = {
      controlMaster = "auto";
      controlPath = "~/.ssh/cm-%r@%h:%p";
      controlPersist = "10m";

      compression = true;
      hashKnownHosts = true;
      forwardAgent = false;

      serverAliveInterval = 60;
      serverAliveCountMax = 3;
      forwardX11 = false;
      forwardX11Trusted = false;

      # Only use keys we specify
      identityFile = ["~/.ssh/id_ed25519"];
    };
  };
}

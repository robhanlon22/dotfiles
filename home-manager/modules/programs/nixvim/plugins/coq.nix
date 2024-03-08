{my, ...}: {
  programs.nixvim.plugins = {
    coq-nvim = {
      enable = true;
      alwaysComplete = true;
      autoStart = "shut-up";
      installArtifacts = true;
      recommendedKeymaps = true;
    };

    coq-thirdparty = with my.nixvim.keymap; {
      enable = true;
      sources = [
        {
          src = "copilot";
          short_name = "COP";
          accept_key = ctrl- "Enter";
        }
      ];
    };
  };
}

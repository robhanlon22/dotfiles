{pkgs, ...}: {
  programs.nixvim = {
    plugins.copilot-lua = {
      enable = true;
      suggestion.enabled = false;
      panel.enabled = false;
    };

    extraPlugins = with pkgs; [
      (vimUtils.buildVimPlugin {
        name = "CopilotChat-nvim";
        src = fetchFromGitHub {
          owner = "CopilotC-Nvim";
          repo = "CopilotChat.nvim";
          rev = "canary";
          hash = "sha256-zbnkO8E7NMC3DamQJo3V9Ui7GmkKZ5b5I5X2do7uGO0=";
        };
      })
    ];
  };
}

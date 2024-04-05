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
          hash = "sha256-EXgJbAueU7YDklmclUlSh/zdYqb0hLF9Imiw+5XKunk=";
        };
      })
    ];
  };
}

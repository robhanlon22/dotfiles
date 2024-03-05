{config, ...}: {
  programs.kitty = {
    enable = true;
    font.name = "Caskaydia Cove Nerd Font Mono";
    keybindings = {
      "cmd+t" = "new_tab_with_cwd";
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      background_blur = "5";
      background_opacity = "0.95";
      bell_on_tab = "🐱 ";
      enable_audio_bell = false;
      hide_window_decorations = "yes";
      inactive_tab_background = "#313244";
      inactive_tab_foreground = "#bac2de";
      shell = "${config.programs.zsh.package}/bin/zsh --interactive --login";
      tab_bar_align = "left";
      tab_bar_background = "none";
      tab_bar_edge = "top";
      tab_bar_margin_height = "15 0";
      tab_bar_margin_width = 4;
      tab_bar_min_tabs = 1;
      tab_bar_style = "fade";
      tab_fade = "0.29629629629 0.44444444444 0.66666666667 1";
      window_margin_width = 10;
      window_padding_width = 10;
    };
    theme = "Catppuccin-Mocha";
  };
}

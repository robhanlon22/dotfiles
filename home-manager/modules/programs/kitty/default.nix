{my, ...}: {
  programs.kitty = {
    enable = true;
    keybindings = {
      "cmd+t" = "new_tab_with_cwd";
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      bell_on_tab = "🐱 ";
      enable_audio_bell = false;
      inactive_tab_background = "#313244";
      inactive_tab_foreground = "#bac2de";
      tab_bar_align = "left";
      tab_bar_background = "none";
      tab_bar_edge = "top";
      tab_bar_margin_height = "15 0";
      tab_bar_margin_width = 5;
      tab_bar_min_tabs = 1;
      tab_bar_style = "fade";
      tab_fade = "0.29629629629 0.44444444444 0.66666666667 1";
      scrollback_pager = ''
        "${my.home.bin}/nvim" -c "silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer -"
      '';
      window_margin_width = 10;
      window_padding_width = 10;
    };
  };
}

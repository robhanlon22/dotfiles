{my, ...}: {
  programs.kitty = {
    enable = true;
    inherit (my.terminal) font;
    keybindings = {
      "cmd+t" = "new_tab_with_cwd";
    };
    shellIntegration.enableZshIntegration = true;
    settings = let
      # Use latte colors because black and white text can render on top of them
      red = "#E78284";
      green = "#A6D189";
      yellow = "#E5C890";
      blue = "#8CAAEE";
      magenta = "#F4B8E4";
      cyan = "#81C8BE";
    in {
      color1 = red;
      color9 = red;
      color2 = green;
      color10 = green;
      color3 = yellow;
      color11 = yellow;
      color4 = blue;
      color12 = blue;
      color5 = magenta;
      color13 = magenta;
      color6 = cyan;
      color14 = cyan;

      background_blur = "5";
      background_opacity = "0.95";
      bell_on_tab = "🐱 ";
      enable_audio_bell = false;
      hide_window_decorations = "yes";
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
    theme = "Catppuccin-Mocha";
  };
}

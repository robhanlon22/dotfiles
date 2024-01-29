{lib, ...}:
with lib.my.config; {
  programs.kitty = enabled {
    font = {
      name = "Caskaydia Cove Nerd Font Mono";
      size = 16;
    };
    settings = {
      macos_option_as_alt = "left";
      macos_titlebar_color = "background";
      shell = "$HOME/.nix-profile/bin/zsh --interactive --login";
      tab_bar_margin_height = "6.0 6.0";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      window_padding_width = 5;
    };
    theme = "Dracula";
  };
}

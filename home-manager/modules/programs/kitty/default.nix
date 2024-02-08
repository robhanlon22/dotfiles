{lib, ...}:
with lib.my.config; {
  programs.kitty = enabled {
    font = {
      name = "Caskaydia Cove Nerd Font Mono";
      size = 16;
    };
    keybindings = {
      "cmd+t" = "new_tab_with_cwd";
    };
    settings = {
      background_opacity = "0.95";
      background_blur = "5";
      bell_on_tab = "🐱 ";
      enable_audio_bell = false;
      hide_window_decorations = "yes";
      macos_option_as_alt = "left";
      macos_titlebar_color = "background";
      shell = "$HOME/.nix-profile/bin/zsh --interactive --login";
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      window_padding_width = 10;
    };
    theme = "Catppuccin-Mocha";
  };
}

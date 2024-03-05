{
  pkgs,
  lib,
  ...
}: let
  yabai = "${pkgs.yabai}/bin/yabai";
  yabairc = pkgs.writeScript "yabairc" (
    lib.pipe {
      active_window_opacity = 1;
      auto_balance = "off";
      external_bar = "all:44:0";
      focus_follows_mouse = "off";
      insert_feedback_color = "0xffd75f5f";
      layout = "stack";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
      mouse_follows_focus = "off";
      mouse_modifier = "fn";
      normal_window_opacity = 0.9;
      split_ratio = 0.5;
      split_type = "auto";
      window_animation_duration = 0;
      window_animation_frame_rate = 120;
      window_opacity = "off";
      window_origin_display = "default";
      window_placement = "second_child";
      window_shadow = "off";
      window_zoom_persist = "on";
    } [
      (lib.mapAttrsToList (p: v: "${yabai} -m config ${p} ${toString v}"))
      (lib.concatStringsSep "\n")
    ]
  );
in {
  config = lib.my.modules.ifDarwin {
    launchd.agents = lib.my.darwin.launchdAgent "yabai" {
      enable = true;
      ProgramArguments = ["${yabai}" "--verbose" "--config" "${yabairc}"];
    };
  };
}

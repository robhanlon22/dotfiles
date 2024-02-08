#!/usr/bin/env bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/icon_map.sh"

if [ "$SENDER" = "front_app_switched" ]; then
  icon_result=
  __icon_map "$INFO"
  sketchybar --set "$NAME" label="$INFO" icon="$icon_result"
fi

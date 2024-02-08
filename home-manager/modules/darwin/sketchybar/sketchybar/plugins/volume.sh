#!/usr/bin/env bash

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME=$INFO

  if ((VOLUME >= 50)); then
    ICON=":volume_high:"
  elif ((VOLUME > 0)); then
    ICON=":volume_low:"
  else
    ICON=":volume_muted:"
  fi

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi

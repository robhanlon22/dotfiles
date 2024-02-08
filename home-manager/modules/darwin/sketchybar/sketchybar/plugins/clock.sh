#!/usr/bin/env bash

HOUR="$(($(date '+%H') % 12))"
ICONS=(󱑖 󱑋 󱑌 󱑍 󱑎 󱑏 󱑐 󱑑 󱑒 󱑓 󱑔 󱑕)

sketchybar --set "$NAME" icon="${ICONS[$HOUR]}" label="$(date '+%Y-%m-%d %H:%M')"

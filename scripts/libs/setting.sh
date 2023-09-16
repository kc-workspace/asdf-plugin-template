#!/usr/bin/env bash

## setting "$component" size
setting() {
  local value component="$1" key="$2" index=0
  for value in "${SETTINGS[@]}"; do
    ((index++))

    if [[ "$value" =~ $component: ]]; then
      printf '%s' "$value" | grep -oE "$key=[^;]+" | sed "s/$key=//"
      return 0
    elif [ "$index" -eq "${#SETTINGS[@]}" ]; then
      printf '%s' "$value" | grep -oE "$key=[^;]+" | sed "s/$key=//"
      return 0
    fi
  done
}

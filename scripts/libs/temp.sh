#!/usr/bin/env bash

## Create directory on temp
temp_dir() {
  local base="${_PATH_TMP:?}" name="${1:?}"
  mktemp -dq "$base/$name.XX"
}

## Create file on temp
temp_file() {
  local base="${_PATH_TMP:?}" name="${1:-}"
  local filename
  [ -z "$name" ] &&
    filename="tmp.XXXXXXXX" ||
    filename="$name.XXX"

  mktemp -q "$base/$filename"
}

## Setup temporary directory
__temp_setup() {
  local base="${_PATH_TMP_BASE:?}"
  local timeout=10800 # 3 hours
  local time_name=.clean-time.tmp
  local time_path="$base/$time_name"

  ## If no temp directory found, create it
  if ! test -d "$base"; then
    logd "create new temp directory"
    mkdir -p "$base"
  fi

  ## If no temp directory found,
  ## create and return as it just created
  if ! test -f "$time_path"; then
    logd "record temp created time"
    date +"%s" >"$time_path"
    return 0
  fi

  local previous current diff
  previous="$(cat "$time_path")"
  current="$(date +"%s")"
  diff="$((current - previous))"

  if [ "$diff" -gt $timeout ]; then
    logd "clean temp directory, and recreate"
    rm -r "$base" &&
      mkdir -p "${_PATH_TMP:?}" &&
      date +"%s" >"$time_path"
  fi
}

_INITIATORS+=(__temp_setup)

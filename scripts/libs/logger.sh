#!/usr/bin/env bash

logd() {
  feat_is_debug || return 0

  local format="$1"
  shift
  # shellcheck disable=SC2059
  printf "[DBG] $format\n" "$@" >>"$_PATH_DEBUG"
}

logi() {
  local format="$1"
  shift
  # shellcheck disable=SC2059
  printf "[INF] $format\n" "$@"
}

loge() {
  local format="$1"
  shift
  # shellcheck disable=SC2059
  printf "[ERR] $format\n" "$@" >&2
  exit 1
}

logf() {
  # shellcheck disable=SC2059
  printf "$@"
}

logln() {
  echo "$@"
}

__log_setup() {
  export _PATH_DEBUG="${_PATH_TMP:?}/debug.log"
}

__log_cleanup() {
  unset _PATH_DEBUG
}

_INITIATORS+=(__log_setup)
_CLEANERS+=(__log_cleanup)

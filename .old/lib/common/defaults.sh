#!/usr/bin/env bash

## Print error message and exit code
## usage: `asdf_error 1 'something went %s' 'wrong'`
asdf_error() {
  local code="$1"
  shift

  asdf_log "ERR" "$@"
  exit "$code"
}

## Print info message
## usage: `asdf_info 'this is a %s message' 'info'`
asdf_info() {
  asdf_log "INF" "$@"
}

## Print debug message
## usage: `asdf_debug 'this is a %s message' 'debug'`
asdf_debug() {
  asdf_on_debug \
    asdf_log "DBG" "$@"
}

## Print log message with format
## usage: `asdf_log '$KEY' 'this is a %s' 'message'`
## format: '[$KEY] $message'
asdf_log() {
  local key="$1" format="$2"
  shift

  # shellcheck disable=SC2059
  printf "[%-3s] $format\n" "$key" "$@" >&2
}

## Execute input command if enabled debug mode
## usage: `asdf_on_debug echo "hello debugger"`
asdf_on_debug() {
  [ -z "${DEBUG:-}" ] &&
    return 0
  "$@"
}

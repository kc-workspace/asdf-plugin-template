#!/usr/bin/env bash

feat_is_debug() {
  __feat_status debug dbg d
}

feat_is_dryrun() {
  __feat_status dry-run dryrun dry dr r
}

feat_is_prod() {
  __feat_status production prod prd p
}

feat_is_prompt() {
  __feat_status prompt prt o
}

feat_is_deploy() {
  __feat_status deployment deploy dpy e
}

feat_is_wait() {
  __feat_status waiting wait wit w
}

feat_is_test() {
  __feat_status test tst t
}

__feat_status() {
  local key enabled
  for enabled in ${FEAT_ENABLED//,/ }; do
    for key in "$@"; do
      if [[ "$key" == "$enabled" ]]; then
        return 0
      fi
    done
  done
  return 1
}

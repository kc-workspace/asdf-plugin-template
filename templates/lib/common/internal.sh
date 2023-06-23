#!/usr/bin/env bash

__asdf_source_bin_lib() {
  local base="$1" name="$2"
  local path="${base}/lib/bin/${name}.sh"

  if [ -f "$path" ]; then
    kc_asdf_debug "sourcing bin:lib (%s)" "$path"
    # shellcheck source=/dev/null
    source "$path"
  else
    kc_asdf_debug "cannot found bin:lib to source (%s)" \
      "$path"
  fi
}

__asdf_bin_unknown() {
  kc_asdf_error "no default commands default (bin/%s)" "$1"
  kc_asdf_throw 2 "please create kc_asdf_main() function"
}

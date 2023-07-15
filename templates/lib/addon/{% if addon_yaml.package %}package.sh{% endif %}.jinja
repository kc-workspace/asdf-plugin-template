#!/usr/bin/env bash

## Unpack package file and move only internal path (if exist)
## usage: `kc_asdf_package_extract /tmp/file.pkg /tmp/file [internal/path]`
kc_asdf_package_extract() {
  local ns="extract.package"
  local input="$1" output="$2" internal="$3" tmppath
  if [ -n "$internal" ]; then
    tmppath="$(kc_asdf_temp_dir)"
  else
    tmppath="$output"
  fi

  ! command -v pkgutil >/dev/null &&
    kc_asdf_error "$ns" "cannot package because 'pkgutil' is missing" &&
    return 1

  if [ -z "${ASDF_INSECURE:-}" ]; then
    kc_asdf_debug "$ns" "verifying package signature of %s" "$input"
    local expected="signed by a developer certificate issued by Apple for distribution"
    local signature actual
    signature="$(kc_asdf_exec pkgutil --check-signature "$input")"
    actual="$(echo "$signature" | grep -E '^\s+Status: ' | sed 's/[ ]*Status: //')"
    if [[ "$expected" != "$actual" ]]; then
      kc_asdf_error "$ns" "invalid pkg signature, please recheck (%s)" \
        "$input"
      echo "$signature" >&2
      return 1
    fi
  fi

  [ -d "$tmppath" ] &&
    kc_asdf_debug "$ns" "delete tmppath directory first" &&
    rm -r "$tmppath"
  kc_asdf_exec pkgutil --expand-full \
    "$input" "$tmppath" ||
    return 1

  if [ -n "$internal" ]; then
    kc_asdf_transfer "move" "$tmppath/$internal" "$output"
    return $?
  fi
}

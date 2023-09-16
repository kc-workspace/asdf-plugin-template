#!/usr/bin/env bash

verify_asdf_latest() {
  local component="$1" step="$2"
  shift 2

  local stdout latest
  stdout="$(db_get_exec_log "$component" "$step")"
  if ! test -f "$stdout"; then
    db_set_verify_msg "$component" "$step" "asdf-latest missing log file"
    return 1
  fi

  latest="$(cat "$stdout")"
  test -z "$latest" &&
    db_set_verify_msg "$component" "$step" "asdf-latest return empty string" &&
    return 1

  db_set_comp_latest "$component" "" "$latest"
  return 0
}

verify_asdf_list() {
  local component="$1" step="$2"
  shift 2

  local stdout expected size=0
  stdout="$(db_get_exec_log "$component" "$step")"
  if ! test -f "$stdout"; then
    db_set_verify_msg "$component" "$step" "asdf-list missing log file"
    return 1
  fi

  expected="$(setting "$component" size)"

  size="$(wc -l <"$stdout" | bc)"
  [ "$size" -lt "$expected" ] &&
    db_set_verify_msg "$component" "$step" \
      "asdf list-all expected to return '$expected', but got '$size'" &&
    return 1

  return 0
}

verify_asdf_install() {
  local component="$1" step="$2"
  shift 2

  local install="$1" latest
  latest="$(db_get_comp_latest "$component")"
  install_path="$install/$latest"

  local root_size=0 bin_size=0
  root_size="$(find "$install_path" -maxdepth 1 | wc -l | bc)"
  bin_size="$(find "$install_path/bin" -maxdepth 1 -type f | wc -l | bc)"

  [ "$root_size" -lt 1 ] || [ "$bin_size" -lt 1 ] &&
    db_set_verify_msg "$component" "$step" \
      "asdf installed path contains nothing ($install_path)" &&
    return 1

  return 0
}

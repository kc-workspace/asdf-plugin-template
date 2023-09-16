#!/usr/bin/env bash

## Verify previous function has no error
check_no_error() {
  local component="$1" step="$2" args=()
  shift 2
  args+=("$@")

  local input index=0 error
  for input in "${args[@]}"; do
    if ! db_has_step_status "$component" "$input"; then
      db_set_check_msg "$component" "${step}[$index]" \
        "input '$input' step doesn't have status"
      error=true
    elif db_is_step_error "$component" "$input" ||
      db_is_step_invalid "$component" "$input"; then
      db_set_check_msg "$component" "${step}[$index]" \
        "input '$input' step either error or invalid"
      error=true
    fi

    ((index++))
  done

  test -z "$error"
}

## Verify all functions has no error
check_no_errors() {
  local component="$1" step="$2" steps=()
  shift 2
  # shellcheck disable=SC2207
  steps=($(db_get_comp_steps "$component"))
  check_no_error "$component" "$step" "${steps[@]}"
}

check_cmd_pass() {
  local component="$1" step="$2"
  shift 2

  "$@" >/dev/null 2>&1
}

check_cmd_fail() {
  local component="$1" step="$2"
  shift 2

  ! "$@" >/dev/null 2>&1
}

check_dir_exist() {
  local component="$1" step="$2" i
  shift 2
  for i in "$@"; do
    if ! test -d "$i"; then
      return 1
    fi
  done
  return 0
}

check_dir_missing() {
  local component="$1" step="$2" i
  shift 2
  for i in "$@"; do
    if test -d "$i"; then
      return 1
    fi
  done
  return 0
}

check_file_exist() {
  local component="$1" step="$2" i
  shift 2
  for i in "$@"; do
    if ! test -f "$i"; then
      return 1
    fi
  done
  return 0
}

#!/usr/bin/env bash

check_must_success() {
  # jscpd:ignore-start
  local component="$1" step="$2" args=()
  shift 2
  args+=("$@")
  # jscpd:ignore-end

  local input index=0 error
  for input in "${args[@]}"; do
    if ! db_has_step_status "$component" "$input"; then
      db_set_check_msg "$component" "$step" \
        "step '$input' doesn't have status"
      error=true
    elif ! db_is_step_success "$component" "$input"; then
      # db_set_check_msg "$component" "$step" \
      #   "step '$input' must be success"
      error=true
    fi

    ((index++))
  done

  test -z "$error"
}

check_no_error() {
  # jscpd:ignore-start
  local component="$1" step="$2" args=()
  shift 2
  args+=("$@")
  # jscpd:ignore-end

  local input index=0 error
  for input in "${args[@]}"; do
    if ! db_has_step_status "$component" "$input"; then
      db_set_check_msg "$component" "${step}" \
        "step '$input' doesn't have status"
      error=true
    elif db_is_step_error "$component" "$input" ||
      db_is_step_invalid "$component" "$input"; then
      db_set_check_msg "$component" "$step" \
        "step '$input' either error or invalid"
      error=true
    fi

    ((index++))
  done

  test -z "$error"
}

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

  __exec "$@" >/dev/null 2>&1
}

check_cmd_fail() {
  local component="$1" step="$2"
  shift 2

  if __exec "$@" >/dev/null 2>&1; then
    return 1
  fi
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

#!/usr/bin/env bash

result_comp_start() {
  local component="$1"
  logf "> $_C_CYAN$component$_C_RESET: "
}

result_comp_step() {
  local component="$1" step="$2" status="$3"

  if test -z "$status"; then
    status="$(db_get_step_status "$component" "$step")"
  fi

  case "$status" in
  "$DB_STATUS_SUCCESS") logf "$_C_GREEN${status:0:1}$_C_RESET" ;;
  "$DB_STEP_STATUS_SKIPPED") logf "$_C_BLUE${status:0:1}$_C_RESET" ;;
  "$DB_STEP_STATUS_ERROR") logf "$_C_RED${status:0:1}$_C_RESET" ;;
  "$DB_STEP_STATUS_INVALID") logf "$_C_PINK${status:0:1}$_C_RESET" ;;
  esac
}

result_comp_stop() {
  logln
}

result_summary_start() {
  logln
  logi ">> Summary results"
}

result_summary_comp_start() {
  local component="$1"
  logf "Component '%s'\n" "$component"
}

result_summary_comp_step() {
  local component="$1" step="$2" status="$3"

  if test -z "$status"; then
    status="$(db_get_step_status "$component" "$step")"
  fi

  if [[ "$status" == "$DB_STEP_STATUS_ERROR" ]] ||
    [[ "$status" == "$DB_STEP_STATUS_INVALID" ]]; then
    local check_msg exec_msg verify_msg
    check_msg="$(db_get_check_msg "$component" "$step")"
    exec_msg="$(db_get_exec_msg "$component" "$step")"
    verify_msg="$(db_get_verify_msg "$component" "$step")"

    test -n "$check_msg" &&
      logln "  - check  : $check_msg"
    test -n "$exec_msg" &&
      logln "  - exec   : $exec_msg"
    test -n "$verify_msg" &&
      logln "  - verify : $verify_msg"
  fi
}

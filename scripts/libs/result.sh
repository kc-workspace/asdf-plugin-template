#!/usr/bin/env bash

result_comp_start() {
  local component="$1"
  logf "> $_C_CYAN%-18s$_C_RESET : " "$component"
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

## All summary will show only when something was wrong
result_summary_start() {
  logln
  logi ">> Summary results"
  logf "   - data  : %s\n" "$_PATH_DB"
  feat_is_debug &&
    logf "   - debug : %s\n" "$_PATH_DEBUG"
  logln
}

result_summary_comp_start() {
  if [ "$_EXIT_CODE" -gt 0 ]; then
    local component="$1"
    logf "Component '%s'\n" "$component"
  fi
}

result_summary_comp_step() {
  local component="$1" step="$2" status="$3"

  if test -z "$status"; then
    status="$(db_get_step_status "$component" "$step")"
  fi

  if [[ "$status" == "$DB_STEP_STATUS_ERROR" ]] ||
    [[ "$status" == "$DB_STEP_STATUS_INVALID" ]]; then
    local check_msg exec_msg exec_log exec_err verify_msg
    check_msg="$(db_get_check_msg "$component" "$step")"
    exec_msg="$(db_get_exec_msg "$component" "$step")"
    exec_log="$(db_get_exec_log "$component" "$step")"
    exec_err="$(db_get_exec_err "$component" "$step")"
    verify_msg="$(db_get_verify_msg "$component" "$step")"

    logln "step: $step ($status)"
    test -n "$check_msg" &&
      logln "  - check    : $check_msg"
    test -n "$exec_msg" &&
      logln "  - exec     : $exec_msg"
    test -n "$exec_log" &&
      logln "  - exec log : $exec_log"
    test -n "$exec_err" &&
      logln "  - exec err : $exec_err"
    test -n "$verify_msg" &&
      logln "  - verify   : $verify_msg"
  fi
}

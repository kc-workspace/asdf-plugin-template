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
  feat_is_debug && logf "   - debug : %s\n" "$_PATH_DEBUG"
  logln
}

result_summary_comp_start() {
  local component="$1"
  logf "Component '%s'\n" "$component"

  if db_is_comp_success "$component"; then
    local latest
    latest="$(db_get_comp_latest "$component")"
    logf "  %-20s %-10s : %s\n" "" "latest" "$latest"
  fi
}

result_summary_comp_step() {
  local component="$1" step="$2" status="$3"

  if test -z "$status"; then
    status="$(db_get_step_status "$component" "$step")"
  fi

  local check_msg exec_msg exec_log exec_err verify_msg
  check_msg="$(db_get_check_msg "$component" "$step")"
  exec_msg="$(db_get_exec_msg "$component" "$step")"
  exec_log="$(db_get_exec_log "$component" "$step")"
  exec_err="$(db_get_exec_err "$component" "$step")"
  verify_msg="$(db_get_verify_msg "$component" "$step")"

  test -n "$check_msg" &&
    logf "  %-20s %-10s : %s\n" "$step" "check" "$check_msg"

  if [[ "$status" == "$DB_STEP_STATUS_ERROR" ]]; then
    test -n "$exec_msg" &&
      logf "  %-20s %-10s : %s\n" "$step" "exec" "$exec_msg"
    test -n "$exec_log" &&
      logf "  %-20s %-10s : %s\n" "" "exec log" "$exec_log"
    test -n "$exec_err" &&
      logf "  %-20s %-10s : %s\n" "" "exec err" "$exec_err"
  fi

  [[ "$status" == "$DB_STEP_STATUS_INVALID" ]] &&
    test -n "$verify_msg" &&
    logf "  %-20s %-10s : %s\n" "$step" "verify" "$verify_msg"
}

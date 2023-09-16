#!/usr/bin/env bash

DB_STATUS_SUCCESS=COMPLETE
DB_STATUS_FAILURE=FAILURE

## If check failed, step status will be skipped
DB_STEP_STATUS_SKIPPED=SKIPPED
## If exec failed, step status will be errors
DB_STEP_STATUS_ERROR=ERROR
## If verify failed, step status will be invalid
DB_STEP_STATUS_INVALID=INVALID

#############################################
## Global level                            ##
#############################################

## db_add_comp_steps "<steps...>"
db_set_components() {
  _db_add components "global" "global" "$@"
}

#############################################
## Component level                         ##
#############################################

## db_add_comp_steps "<component>" "" "<steps...>"
db_add_comp_steps() {
  _db_add steps "$@"
}
## db_get_comp_steps "<component>" ""
db_get_comp_steps() {
  _db_get steps "$@"
}
db_set_comp_status() {
  _db_set status "$@"
}
db_has_comp_status() {
  _db_has status "$@"
}
db_is_comp_success() {
  _db_check status "$@" "$DB_STATUS_SUCCESS"
}
db_is_comp_failure() {
  _db_check status "$@" "$DB_STATUS_FAILURE"
}

#############################################
## Component steps level                   ##
#############################################

db_set_step_status() {
  _db_set step.status "$@"
}
db_has_step_status() {
  _db_has step.status "$@"
}
db_get_step_status() {
  _db_get step.status "$@"
}
db_is_step_success() {
  _db_check step.status "$@" "$DB_STATUS_SUCCESS"
}
db_is_step_skipped() {
  _db_check step.status "$@" "$DB_STEP_STATUS_SKIPPED"
}
db_is_step_error() {
  _db_check step.status "$@" "$DB_STEP_STATUS_ERROR"
}
db_is_step_invalid() {
  _db_check step.status "$@" "$DB_STEP_STATUS_INVALID"
}

db_set_check_status() {
  _db_set check.status "$@"
}
db_is_check_success() {
  _db_check check.status "$@" "$DB_STATUS_SUCCESS"
}
db_is_check_failure() {
  _db_check check.status "$@" "$DB_STATUS_FAILURE"
}
db_set_check_func() {
  _db_set check.func "$@"
}
db_get_check_func() {
  _db_get check.func "$@"
}
db_set_check_cmd() {
  _db_set check.cmd "$@"
}
db_get_check_cmd() {
  _db_get check.cmd "$@"
}
db_set_check_msg() {
  _db_set check.msg "$@"
}
db_get_check_msg() {
  _db_get check.msg "$@"
}

db_set_exec_status() {
  _db_set exec.status "$@"
}
db_is_exec_success() {
  _db_check exec.status "$@" "$DB_STATUS_SUCCESS"
}
db_is_exec_failure() {
  _db_check exec.status "$@" "$DB_STATUS_FAILURE"
}
db_set_exec_func() {
  _db_set exec.func "$@"
}
db_get_exec_func() {
  _db_get exec.func "$@"
}
db_set_exec_cmd() {
  _db_set exec.cmd "$@"
}
db_get_exec_cmd() {
  _db_get exec.cmd "$@"
}
db_set_exec_msg() {
  _db_set exec.msg "$@"
}
db_get_exec_msg() {
  _db_get exec.msg "$@"
}
db_set_exec_log() {
  _db_set exec.log "$@"
}
db_get_exec_log() {
  _db_get exec.log "$@"
}
db_set_exec_err() {
  _db_set exec.err "$@"
}
db_get_exec_err() {
  _db_get exec.err "$@"
}

db_set_verify_status() {
  _db_set verify.status "$@"
}
db_is_verify_success() {
  _db_check verify.status "$@" "$DB_STATUS_SUCCESS"
}
db_is_verify_failure() {
  _db_check verify.status "$@" "$DB_STATUS_FAILURE"
}
db_set_verify_func() {
  _db_set verify.func "$@"
}
db_get_verify_func() {
  _db_get verify.func "$@"
}
db_set_verify_cmd() {
  _db_set verify.cmd "$@"
}
db_get_verify_cmd() {
  _db_get verify.cmd "$@"
}
db_set_verify_msg() {
  _db_set verify.msg "$@"
}
db_get_verify_msg() {
  _db_get verify.msg "$@"
}

_db_set() {
  local database="${_PATH_DB:?}"
  local sep="=" name="${1:?}"
  local component="${2:?}" step="${3:-global}"
  shift 3
  local key="$component.$step.$name"
  local value="$*"

  if test -f "$database" && grep -qE "^$key$sep" "$database"; then
    logd "remove previous value '%s' at '%s'" "$value" "$key"
    ## FIXME: Only sed on MacOS that -i requires argument
    sed -i '' "/^$key$sep/d" "$database"
  fi

  logd "save '%s' ('%s') on database" "$key" "$value"
  echo "$key$sep${value:-true}" >>"$database"
}

_db_get() {
  local database="${_PATH_DB:?}"
  local sep="=" name="${1:?}"
  local component="${2:?}" step="${3:-global}"
  local key="$component.$step.$name"
  if [ -f "$database" ]; then
    local line
    line="$(grep -E "^$key$sep" "$database" | tail -n 1)"
    local value="${line#*"$sep"}"
    if [ -n "$value" ]; then
      printf "%s" "$value"
      return 0
    fi
    logd "missing key '%s' from database" "$key"
    return 0
  fi
  logd "database missing (%s)" "$database"
}

_db_has() {
  local database="${_PATH_DB:?}"
  local sep="=" name="${1:?}"
  local component="${2:?}" step="${3:-global}"
  local key="$component.$step.$name"
  [ -f "$database" ] && grep -qE "^$key$sep" "$database"
}

_db_add() {
  local database="${_PATH_DB:?}"
  local sep="=" name="${1:?}"
  local component="${2:?}" step="${3:-global}"
  local key="$component.$step.$name"

  if test -f "$database" && grep -qE "^$key$sep" "$database"; then
    local prev
    prev="$(_db_get "$@")"
    shift 3
    _db_set "$name" "$component" "$step" "$prev" "$@"
  else
    _db_set "$@"
  fi
}

_db_check() {
  local database="${_PATH_DB:?}"
  local sep="=" name="${1:?}"
  local component="${2:?}" step="${3:-global}"
  local key="$component.$step.$name"
  shift 3

  [ -f "$database" ] && grep -qE "^$key$sep$*" "$database"
}

__db_setup() {
  _PATH_DB="${_PATH_TMP:?}/.data.properties"
}

__db_cleanup() {
  unset _PATH_DB
  unset DB_STATUS_FAILURE DB_STATUS_SUCCESS
  unset DB_STEP_STATUS_SKIPPED DB_STEP_STATUS_ERROR DB_STEP_STATUS_INVALID
}

_INITIATORS+=(__db_setup)
_CLEANERS+=(__db_cleanup)

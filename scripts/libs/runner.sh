#!/usr/bin/env bash

runner_start() {
  result_comp_start "$@"
}

## runner <component> <step> \
##   $ check_prev_errors \
##   $ exec_with_logfile asdf plugin list \
##   $ verify_no_errors
runner() {
  local component="$1" step="$2" seperator="$"
  shift 2

  local raw=("$@" "$")
  local stage=check cmd="" args=() input status
  for input in "${raw[@]}"; do
    if [[ "$input" == "$seperator" ]]; then
      if test -n "$cmd"; then
        case "$stage" in
        check)
          db_set_check_func "$component" "$step" "$cmd"
          [ "${#args[@]}" -gt 0 ] &&
            db_set_check_cmd "$component" "$step" "${args[@]}"
          ;;
        exec)
          db_set_exec_func "$component" "$step" "$cmd"
          db_set_exec_cmd "$component" "$step" "${args[@]}"
          ;;
        verify)
          db_set_verify_func "$component" "$step" "$cmd"
          [ "${#args[@]}" -gt 0 ] &&
            db_set_verify_cmd "$component" "$step" "${args[@]}"
          ;;
        esac

        if "${cmd:?}" "$component" "$step" "${args[@]}"; then
          status="$DB_STATUS_SUCCESS"
        else
          status="$DB_STATUS_FAILURE"
        fi

        case "$stage" in
        check)
          db_set_check_status "$component" "$step" "$status"
          [[ "$status" == "$DB_STATUS_FAILURE" ]] &&
            db_set_step_status "$component" "$step" "$DB_STEP_STATUS_SKIPPED" &&
            break
          ;;
        exec)
          db_set_exec_status "$component" "$step" "$status"
          [[ "$status" == "$DB_STATUS_FAILURE" ]] &&
            db_set_step_status "$component" "$step" "$DB_STEP_STATUS_ERROR" &&
            break
          ;;
        verify)
          db_set_verify_status "$component" "$step" "$status"
          [[ "$status" == "$DB_STATUS_FAILURE" ]] &&
            db_set_step_status "$component" "$step" "$DB_STEP_STATUS_INVALID" &&
            break
          ;;
        esac
      fi

      cmd="" && args=()
      continue
    fi

    test -n "$cmd" &&
      args+=("$input") &&
      continue

    cmd="$input"
    if [[ "$stage" != "${cmd%%_*}" ]]; then
      case "${stage}-${cmd%%_*}" in
      exec-check | verify-check | verify-exec)
        loge "Runner functions must follow this seq (check -> exec -> verify)"
        ;;
      esac
      stage="${cmd%%_*}"
    fi
  done

  if ! db_has_step_status "$component" "$step"; then
    db_set_step_status "$component" "$step" "$DB_STATUS_SUCCESS"
  fi

  result_comp_step "$component" "$step"
  db_add_comp_steps "$component" "" "$step"
}

runner_summary() {
  local component="$1"

  local steps=() step
  # shellcheck disable=SC2207
  steps=($(db_get_comp_steps "$component"))
  for step in "${steps[@]}"; do
    if db_is_step_error "$component" "$step" ||
      db_is_step_invalid "$component" "$step"; then
      db_set_comp_status "$component" "" "$DB_STATUS_FAILURE"
      ((_EXIT_CODE++))
      return 1
    fi
  done

  db_set_comp_status "$component" "" "$DB_STATUS_SUCCESS"
  result_comp_stop
}

__runner_cleanup() {
  unset __RUNNER_PREFIX
}

_CLEANERS+=(__runner_cleanup)

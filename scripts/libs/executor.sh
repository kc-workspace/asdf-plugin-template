#!/usr/bin/env bash

exec_default() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  shift 2

  __exec_cmd "$@"
}

exec_ignore() {
  exec_with_logfile "$@"
  return 0
}

exec_with_logfile() {
  local component="${1:?component is missing}" step="${2:?step is missing}" log
  log="$(temp_file "$step")"
  shift 2

  db_set_exec_log "$component" "$step" "$log"
  __exec_cmd "$@" >"$log" 2>&1
}

exec_with_outfile() {
  local component="${1:?component is missing}" step="${2:?step is missing}" log
  log="$(temp_file "$step")"
  shift 2

  db_set_exec_log "$component" "$step" "$log"
  __exec_cmd "$@" >"$log"
}

exec_with_file() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  local stdout stderr
  stdout="$(temp_file "$step-stdout")"
  stderr="$(temp_file "$step-stderr")"
  shift 2

  db_set_exec_log "$component" "$step" "$stdout"
  db_set_exec_err "$component" "$step" "$stderr"
  __exec_cmd "$@" >"$stdout" 2>"$stderr"
}

exec_without_stdout() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  shift 2

  __exec_cmd "$@" >/dev/null
}

exec_copier() {
  if [[ "$*" =~ --defaults ]]; then
    exec_with_logfile "$@"
  else
    exec_default "$@"
  fi
}

__exec_cmd() {
  local cmd="${1:?command is missing}"
  shift

  test -f "$_PATH_SCP/bin/$cmd" && cmd="$_PATH_SCP/bin/$cmd"
  if ! feat_is_dryrun; then
    "$cmd" "$@"
  fi
}

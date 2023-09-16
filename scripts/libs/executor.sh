#!/usr/bin/env bash

exec_default() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  shift 2

  __exec_cmd "$component" "$step" "$@"
}

exec_ignore() {
  exec_with_logfile "$@"
  return 0
}

exec_with_logfile() {
  local component="${1:?component is missing}" step="${2:?step is missing}" log
  log="$(temp_file "$component-$step")"
  shift 2

  db_set_exec_log "$component" "$step" "$log"
  __exec_cmd "$component" "$step" "$@" >"$log" 2>&1
}

exec_with_outfile() {
  local component="${1:?component is missing}" step="${2:?step is missing}" log
  log="$(temp_file "$component-$step")"
  shift 2

  db_set_exec_log "$component" "$step" "$log"
  __exec_cmd "$component" "$step" "$@" >"$log"
}

exec_with_file() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  local stdout stderr
  stdout="$(temp_file "$component-$step-stdout")"
  stderr="$(temp_file "$component-$step-stderr")"
  shift 2

  db_set_exec_log "$component" "$step" "$stdout"
  db_set_exec_err "$component" "$step" "$stderr"
  if ! __exec_cmd "$component" "$step" "$@" >"$stdout" 2>"$stderr"; then
    db_set_exec_msg "$component" "$step" "$(head -n1 "$stderr")"
    return 1
  fi
}

exec_without_stdout() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  shift 2

  __exec_cmd "$component" "$step" "$@" >/dev/null
}

exec_copier() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  shift 2

  local install_path="${1:?install path is missing}"
  local template="$_PATH_CWD" cmd="python" args=(-m copier)
  args+=(copy)
  args+=(--trust --overwrite)

  if feat_is_prod; then
    template="gh:kc-workspace/asdf-plugin-template.git"
  else
    args+=(--vcs-ref HEAD)
  fi

  if feat_is_prompt; then
    exec_default "$component" "$step" \
      "$cmd" "${args[@]}" "$template" "$install_path"
  else
    args+=(--defaults)
    exec_with_logfile "$component" "$step" \
      "$cmd" "${args[@]}" "$template" "$install_path"
  fi
}

__exec_cmd() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  local cmd="${3:?command is missing}"
  shift 3

  test -f "$_PATH_SCP/bin/$cmd" && cmd="$_PATH_SCP/bin/$cmd"

  db_set_exec_cmd "$component" "$step" "$cmd" "$@"
  if ! feat_is_dryrun; then
    "$cmd" "$@"
  fi
}

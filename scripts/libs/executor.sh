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

exec_with_file() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  local stdout stderr
  stdout="$(temp_file "$component-$step-stdout")"
  stderr="$(temp_file "$component-$step-stderr")"
  shift 2

  db_set_exec_log "$component" "$step" "$stdout"
  db_set_exec_err "$component" "$step" "$stderr"
  if ! __exec_cmd "$component" "$step" "$@" >"$stdout" 2>"$stderr"; then
    db_set_exec_msg "$component" "$step" "$(tail -n1 "$stderr")"
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
  local template="$_PATH_CWD"

  local cmd args
  if command -v copier >/dev/null; then
    cmd="copier" args=()
  else
    cmd="python" args=(-m copier)
  fi

  args+=(copy)
  args+=(--trust --overwrite)

  if feat_is_prod; then
    template="gh:kc-workspace/asdf-plugin-template.git"
  else
    args+=(--vcs-ref HEAD)
  fi

  ## Enabled prompt mode if user enabled or on newly create plugin
  if feat_is_prompt || ! test -d "$install_path"; then
    exec_default "$component" "$step" \
      "$cmd" "${args[@]}" "$template" "$install_path"
  else
    args+=(--defaults)
    exec_with_logfile "$component" "$step" \
      "$cmd" "${args[@]}" "$template" "$install_path"
  fi
}

exec_gh_actions_watch() {
  local component="${1:?component is missing}" step="${2:?step is missing}"
  local repo="${3:?github repo is missing}"

  local timeout=30 json id status
  json="$(temp_file)"

  for ((i = 0; i <= timeout; i++)); do
    __exec gh run list --limit 1 \
      --repo "$repo" --workflow 'main' --json 'databaseId,status' >"$json"

    status="$(__exec jq -Mr '.[0].status' "$json")"
    if [[ "$status" == "in_progress" ]]; then
      id="$(__exec jq -Mr '.[0].databaseId' "$json")"
      exec_with_logfile "$component" "$step" \
        gh run watch --exit-status --repo "$repo" "$id"
      return $?
    fi

    sleep 1
  done

  db_set_exec_msg "$component" "$step" "github actions timeout (${timeout}s)"
  return 1
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

__exec() {
  local cmd="${1:?command is missing}"
  shift
  test -f "$_PATH_SCP/bin/$cmd" && cmd="$_PATH_SCP/bin/$cmd"
  "$cmd" "$@"
}

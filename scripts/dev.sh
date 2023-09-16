#!/usr/bin/env bash

## example: ./scripts/dev.sh argocd
## variables:
##   - $DEV_DEBUG=1
##         to enabled debug mode
##   - $DRYRUN=1
##         to enabled dryrun mode
##   - $FORMAT=[short|normal|long]
##         to custom output format
##   - $DEV_ENABLED=prod,prompt,git,wait,single
##         to enabled several features
##   - $DEV_DISABLED=list,test
##         to disabled several features

export COMPONENTS=(
  '1password'
  argocd aws
  cloudflared cmctl consul cookiecutter copier
  flux2
  gh git-chglog go-jsonnet golang golangci-lint gradle
  helm hub hyperfine
  jq jsonnet-bundler
  k6 kind kubectl
  maven mkcert
  pipx
  terraform terragrunt
  yamllint yq
)

export COMPONENTS_LIST_SIZE=(
  "1password:66"
  "cookiecutter:38"
  "copier:57"
  "git-chglog:14"
  "go-jsonnet:15"
  "hyperfine:23"
  "jq:13"
  "jsonnet-bundler:6"
  "k6:83"
  "kind:32"
  "maven:77"
  "mkcert:14"
  "pipx:55"
  "yamllint:65"
  "_:99"
)

main() {
  local workdir="$_ROOT"

  local name
  local plugin_name plugin_repo
  local local_path plugin_path
  local install_path

  local addon_path lib_bin_path

  local tmpdir
  tmpdir="$(tmp_basepath)"

  is_debug &&
    log_info "enabled debug mode [cat $tmpdir/debug.log]"
  log_debug "start dev.sh '%s'" "$*"
  db_set_components "$@"
  for name in "$@"; do
    plugin_name="asdf-$name"
    plugin_repo="kc-workspace/$plugin_name"

    local_path="$workdir/.temp/$plugin_name"
    plugin_path="$HOME/.asdf/plugins/$name"
    install_path="$HOME/.asdf/installs/$name"

    start "$name"
    step "$name" "create-gh-repo" \
      _if_no_gh_repo "$plugin_repo" \
      _exec_silent \
      gh repo create --disable-wiki --public "$plugin_repo" \
      _verify_noop

    addon_path="$local_path/lib/addon"
    step "$name" "remove-addon" \
      _if_dir_exist "$addon_path" \
      _exec_silent \
      rm -r "$addon_path" \
      _verify_noop

    lib_bin_path="$local_path/lib/bin"
    step "$name" "remove-lib-bin" \
      _if_dir_exist "$lib_bin_path" \
      _exec_silent \
      rm -r "$lib_bin_path" \
      _verify_noop

    local template="$workdir"
    feat_enabled_prod &&
      template="gh:kc-workspace/asdf-plugin-template.git"
    step "$name" "copier-copy" \
      _if_copier_exist "$local_path" \
      _exec_copier \
      python -m copier copy --trust "$template" "$local_path" \
      _verify_noop

    step "$name" "remove-plugin" \
      _if_dir_exist "$plugin_path" \
      _exec_silent \
      rm -fr "$plugin_path" \
      _verify_noop

    step "$name" "deploy-plugin" \
      _if_no_fail \
      _exec_silent \
      cp -r "$local_path" "$plugin_path" \
      _verify_noop

    step "$name" "get-latest" \
      _if_cb feat_disabled_list \
      _exec_with_errfile \
      asdf latest "$name" \
      _verify_asdf_latest

    local latest
    latest="$(db_get_comp_latest "$name")"

    step "$name" "list-all" \
      _if_cb feat_disabled_list \
      _exec_silent \
      asdf list all "$name" \
      _verify_asdf_list

    DEBUG=1 step "$name" "install-latest" \
      _if_cb feat_disabled_test \
      _exec_silent \
      asdf install "$name" latest \
      _verify_noop

    step "$name" "list-path" \
      _if_cb feat_disabled_test \
      _exec_with_errfile \
      ls -A "$install_path/$latest" \
      _verify_ls "$install_path/$latest"

    step "$name" "list-bin-path" \
      _if_cb feat_disabled_test \
      _exec_with_errfile \
      ls -A "$install_path/$latest/bin" \
      _verify_ls "$install_path/$latest/bin"

    step "$name" "shell-latest" \
      _if_cb feat_disabled_test \
      _exec_silent \
      asdf shell "$name" "$latest" \
      _verify_noop

    step "$name" "test-latest" \
      _if_cb feat_disabled_test \
      _exec_silent \
      asdf "$name" test \
      _verify_output

    DEBUG=1 step "$name" "uninstall-latest" \
      _if_cb feat_disabled_test \
      _exec_silent \
      asdf uninstall "$name" "$latest" \
      _verify_noop

    step "$name" "git-pull" \
      _if_git_outdate feat_enabled_git "$local_path" \
      _exec_ignore \
      git -C "$local_path" pull origin main \
      _verify_noop

    step "$name" "git-add-all" \
      _if_git_dirty feat_enabled_git "$local_path" \
      _exec_silent \
      git -C "$local_path" add --all \
      _verify_noop

    step "$name" "git-commit" \
      _if_git_dirty feat_enabled_git "$local_path" \
      _exec_silent \
      git -C "$local_path" commit -m 'perf: update plugin from template [autocommit]' \
      _verify_noop

    step "$name" "git-push" \
      _if_git_outdate feat_enabled_git "$local_path" \
      _exec_silent \
      git -C "$local_path" push origin main \
      _verify_noop

    step "$name" "wait-workflow" \
      _if_gh_workflow_exist feat_enabled_wait "$plugin_repo" \
      _exec_silent \
      gh run watch --exit-status --repo "$plugin_repo" \
      _verify_noop

    local status
    status="$(db_get_comp_status "$name")"
    stop "$name" "$tmpdir" "$status"
    if [ "$status" == "failed" ]; then
      ((_EXIT_CODE++))
    fi

    if feat_enabled_single; then
      logf '>> Waiting... [enter] to continue: '
      read -r
    fi
  done
}

start() {
  local key="$1"
  ((COMPONENT_COUNT++))

  print_start "$key"
}
step() {
  local key="$1" name="$2"
  shift

  print_step "$key" "$name"

  local disabled
  disabled="$(db_get_disabled "$key" "$name")"
  if [ -n "$disabled" ]; then
    print_disabled "$key" "$name"
    return 0
  fi

  local cmd_index=-1
  local checker="" checker_args=()
  local executor="" executor_args=()
  local validator="" validator_args=()

  for arg in "$@"; do
    if [[ "$arg" =~ ^_[a-z] ]]; then
      ((cmd_index++))
      case "$cmd_index" in
      0) checker="$arg" ;;
      1) executor="$arg" ;;
      2) validator="$arg" ;;
      esac
    else
      case "$cmd_index" in
      0) checker_args+=("$arg") ;;
      1) executor_args+=("$arg") ;;
      2) validator_args+=("$arg") ;;
      esac
    fi
  done

  log_debug "checker '%s[%s]' starting: %s %s" \
    "$key" "$name" "$checker" "${checker_args[*]}"
  print_step_check \
    "$key" "$name" "$checker" "${checker_args[@]}"
  if ! "$checker" "$key" "$name" "${checker_args[@]}"; then
    log_debug "checker '%s' result: skipped" "$key"
    db_set_comp_status "$key" "$name" "skipped"
    print_checker_failed "$key" "$name"
    return 0
  fi

  local args=()
  IFS=" " read -ra args <<<"$(db_get_exec_args "$key" "$name")"
  if [ "${#args[@]}" -gt 0 ]; then
    executor_args+=("${args[@]}")
  fi

  log_debug "executor '%s[%s]' starting: %s %s" \
    "$key" "$name" "$executor" "${executor_args[*]}"
  print_step_exec \
    "$key" "$name" "$executor" "${executor_args[@]}"
  if ! is_dryrun; then
    if ! "$executor" "$key" "$name" "${executor_args[@]}"; then
      log_debug "executor '%s' result: failed" \
        "$key"
      db_set_comp_status "$key" "$name" "failed"
      print_executor_failed "$key" "$name"
      return 0
    fi
  fi

  log_debug "validator '%s[%s]' starting: %s %s" \
    "$key" "$name" "$validator" "${validator_args[*]}"
  print_step_verify \
    "$key" "$name" "$validator" "${validator_args[@]}"
  if ! is_dryrun; then
    if ! "$validator" "$key" "$name" "${validator_args[@]}"; then
      log_debug "validator '%s[%s]' result: failed" \
        "$key" "$name"
      db_set_comp_status "$key" "$name" "failed"
      print_validator_failed "$key" "$name"
      return 0
    fi
  fi

  print_success "$key" "$name"
  if ! is_dryrun; then
    db_set_comp_status "$key" "$name" "success"
  fi
  return 0
}
stop() {
  local key="$1" tmpdir="$2" status="$3"

  [ -z "$status" ] &&
    db_set_comp_status "$key" "success"
  print_stop "$key" "$tmpdir"
}
disabled() {
  local _start="$1" key="$2" name="$3"
  shift 3

  db_set_disabled "$key" "$name" "true"
  "$_start" "$key" "$name"
}

_if_true() {
  local key="$1" name="$2"
  shift 2

  return 0
}
_if_cb() {
  local key="$1" name="$2"
  shift 2
  local cb="$1"
  if ! "$cb"; then
    db_set_check_msg "$key" "$name" "$cb"
    return 1
  fi
  _if_no_fail "$key" "$name" || return 1
  return 0
}
_if_no_fail() {
  local key="$1" name="$2"
  shift 2

  local status
  status="$(db_get_comp_status "$key")"
  if [[ "$status" == "failed" ]]; then
    db_set_check_msg "$key" "previous step error"
    return 1
  fi
}
_if_no_gh_repo() {
  local key="$1" name="$2"
  shift 2

  log_debug "checking 'gh' command"
  if ! command -v gh >/dev/null; then
    db_set_check_msg "$key" "$name" "'gh' command is missing"
    return 1
  fi

  local repo="${1:?}"
  log_debug "is github repository exist?"
  if gh repo view "$repo" --json 'name' >/dev/null 2>&1; then
    db_set_check_msg "$key" "$name" "repository already created"
    return 1
  fi

  log_debug "no github repository on GitHub website"
  return 0
}
_if_gh_workflow_exist() {
  local key="$1" name="$2"
  _if_cb "$@" || return 1
  shift 3

  log_debug "checking 'gh' command"
  if ! command -v gh >/dev/null; then
    db_set_check_msg "$key" "$name" "'gh' command is missing"
    return 1
  fi

  local repo="${1:?}"
  local json
  json="$(tmp_create_file 'gh-workflow-list')"

  local i=0 max=30 workflow_status
  while true; do
    if [ $i -gt $max ]; then
      db_set_check_msg "$key" "$name" "cannot wait any longer (${max}s) for workflow to start"
      return 1
    fi

    gh run list \
      --repo "$repo" \
      --limit 1 \
      --workflow 'main' \
      --json 'databaseId,status' >"$json"
    workflow_status="$(jq -Mr '.[0].status' "$json")"
    if [[ "$workflow_status" == "in_progress" ]]; then
      break
    fi

    sleep 1
    ((i++))
  done

  local workflow_id
  workflow_id="$(jq -Mr '.[0].databaseId' "$json")"
  db_set_exec_args "$key" "$name" \
    "$workflow_id"
}
_if_dir_exist() {
  local key="$1" name="$2"
  shift 2

  if ! [ -d "${1:?}" ]; then
    db_set_check_msg "$key" "$name" "$1 is missing"
    return 1
  fi

  _if_no_fail "$key" "$name" || return 1
  return 0
}
_if_copier_exist() {
  local key="$1" name="$2"
  shift 2

  _if_no_fail "$key" "$name" || return 1

  local args=()
  if ! feat_enabled_prod; then
    args+=(--vcs-ref HEAD)
  fi
  args+=(--overwrite)
  if [ -d "${1:?}" ] && ! feat_enabled_prompt; then
    args+=(--defaults)
  fi

  db_set_exec_args "$key" "$name" "${args[@]}"
}
_if_var_exist() {
  local key="$1" name="$2"
  shift 2
  local var
  eval "var=\"\$${1// /}\""
  if [ -z "${var:-}" ]; then
    db_set_check_msg "$key" "$name" "\$$1 must be set"
    return 1
  fi
  _if_no_fail "$key" "$name" || return 1
  return 0
}
_if_var_miss() {
  local key="$1" name="$2"
  shift 2
  local var
  eval "var=\"\$${1// /}\""
  if [ -n "${var:-}" ]; then
    db_set_check_msg "$key" "$name" "\$$1 is set"
    return 1
  fi
  _if_no_fail "$key" "$name" || return 1
  return 0
}
_if_git_dirty() {
  local key="$1" name="$2"
  _if_cb "$@" || return 1
  shift 3

  local dir="$1"
  if [ -d "$dir" ]; then
    log_debug "checking how dirty git are on %s" "$dir"
    if git -C "$dir" update-index -q --really-refresh --ignore-submodules &&
      git -C "$dir" diff-index --quiet --exit-code --ignore-submodules HEAD; then
      db_set_check_msg "$key" "$name" "git was cleaned"
      return 1
    fi
  else
    log_debug "skipped checking git repository because directory(%s) missing" "$dir"
  fi
}
_if_git_outdate() {
  local key="$1" name="$2"
  _if_cb "$@" || return 1
  shift 3

  local dir="$1"
  if [ -d "$dir" ]; then
    log_debug "checking remote git outdated at %s" "$dir"
    if git -C "$dir" push --dry-run origin main --porcelain |
      grep -q 'up to date'; then
      db_set_check_msg "$key" "$name" "git was up-to-date"
      return 1
    fi
  else
    log_debug "skipped checking git repository because directory(%s) missing" "$dir"
  fi
}

_exec_silent() {
  local key="$1" name="$2"
  shift 2

  local logfile
  logfile="$(tmp_create_file "$name")"

  log_debug "executor logs: '$logfile'"
  db_set_exec_cmd "$key" "$name" "$@"
  db_set_exec_log "$key" "$name" "$logfile"
  "$@" >"$logfile" 2>&1
}
_exec_ignore() {
  if ! _exec_silent "$@"; then
    return 0
  fi
}
_exec_prompt() {
  local key="$1" name="$2" args=()
  shift 2

  db_set_exec_cmd "$key" "$name" "$@"
  "$@"
}
_exec_default() {
  local key="$1" name="$2"
  shift 2

  local logfile
  logfile="$(tmp_create_file "$name")"

  log_debug "executor logs: '$logfile'"
  db_set_exec_cmd "$key" "$name" "$@"
  db_set_exec_log "$key" "$name" "$logfile"
  "$@" >"$logfile"
}
_exec_with_errfile() {
  local key="$1" name="$2"
  shift 2

  local logfile errfile
  logfile="$(tmp_create_file "$name.log")"
  errfile="$(tmp_create_file "$name.err")"

  log_debug "executor logs: '$logfile'"
  db_set_exec_cmd "$key" "$name" "$@"
  db_set_exec_log "$key" "$name" "$logfile"
  if ! "$@" >"$logfile" 2>"$errfile"; then
    log_debug "executor errors: '$errfile'"
    db_set_exec_err "$key" "$name" "$errfile"
    return 1
  fi
}
_exec_copier() {
  if [[ "$*" =~ --defaults ]]; then
    _exec_silent "$@"
  else
    _exec_prompt "$@"
  fi
}

_verify_noop() {
  local key="$1" name="$2"
  shift 2

  return 0
}
_verify_asdf_latest() {
  local key="$1" name="$2"
  shift 2

  local logfile
  logfile="$(db_get_exec_log "$key" "$name")"

  if ! [ -f "$logfile" ]; then
    db_set_verify_msg "$key" "$name" "latest version is missing"
    return 1
  fi

  local latest
  latest="$(cat "$logfile")"
  if [ -n "$latest" ]; then
    db_set_comp_latest "$key" "$latest"
    db_set_success_msg "$key" "$name" "latest=$latest"
    return 0
  fi
}
_verify_asdf_list() {
  local key="$1" name="$2"
  shift 2

  local logfile size
  logfile="$(db_get_exec_log "$key" "$name")"
  size="$(echo "${COMPONENTS_LIST_SIZE[*]}" |
    grep -oE "$key:[0-9]+" |
    sed "s/$key://")"
  test -z "$size" &&
    size="$(echo "${COMPONENTS_LIST_SIZE[*]}" |
      grep -oE "_:[0-9]+" |
      sed "s/_://")"

  if ! [ -f "$logfile" ]; then
    db_set_verify_msg "$key" "$name" "list-all didn't return any version"
    return 1
  fi

  local line=0
  line="$(wc -l <"$logfile" | bc)"
  if [[ "$line" -lt $size ]]; then
    db_set_verify_msg "$key" "$name" "size=$line<$size"
    return 1
  fi

  db_set_success_msg "$key" "$name" "size=$line"
  db_set_success_log "$key" "$name" "$logfile"
}
_verify_ls() {
  local key="$1" name="$2"
  shift 2

  local path="$1"
  local logfile
  logfile="$(db_get_exec_log "$key" "$name")"

  local files line=0
  files="$(xargs echo <"$logfile")"
  line="$(echo "$files" | wc -w | bc)"
  if [[ "$line" -lt 1 ]]; then
    db_set_verify_msg "$key" "$name" "empty directory detected at $path"
    return 1
  fi

  db_set_success_msg "$key" "$name" "{$line} ${files}"
}
_verify_output() {
  local key="$1" name="$2"
  shift 2

  local logfile output
  logfile="$(db_get_exec_log "$key" "$name")"
  output="$(xargs echo <"$logfile")"

  db_set_success_msg "$key" "$name" "$output"
}

print_start() {
  local key="$1"

  if is_format_short; then
    printf "%-15s: " "$key"
  elif is_format_normal; then
    echo
    printf "# $CYAN_COLOR%s$RESET_COLOR\n" "$key"
  elif is_format_long; then
    echo
    printf "# $CYAN_COLOR%s$RESET_COLOR\n" "$key"
  fi
}
print_stop() {
  local key="$1" tmpdir="$2"
  shift 2

  if is_format_short; then
    logln
  fi
}
print_step() {
  local key="$1" name="$2"
  shift 2

  if is_format_normal; then
    logf '=> %-20s' "$name"
  elif is_format_long; then
    logf '$ %s' "$name"
  fi
}
print_step_check() {
  local key="$1" name="$2" fn="$3"
  shift 3

  if is_format_normal; then
    logf ': '
  fi
}
print_step_exec() {
  local key="$1" name="$2" fn="$3"
  shift 3

  if is_format_long; then
    logf ' [%s]' "$*"
  fi
}
print_step_verify() {
  # shellcheck disable=SC2034
  local key="$1" name="$2" fn="$3"
  shift 3

  return 0
}
print_checker_failed() {
  local key="$1" name="$2"
  __print_result "$BLUE_COLOR" "SKIPPED" "$key" "$name" \
    "db_get_check_msg" "db_get_check_log"
}
print_executor_failed() {
  local key="$1" name="$2"
  __print_result "$RED_COLOR" "FAILED" "$key" "$name" \
    "db_get_exec_msg" "db_get_exec_log" "db_get_exec_err"
  db_set_comp_status "$key" "failed"
}
print_validator_failed() {
  local key="$1" name="$2"
  __print_result "$RED_COLOR" "FAILED" "$key" "$name" \
    "db_get_verify_msg" "db_get_verify_log"
  db_set_comp_status "$key" "failed"
}
print_success() {
  local key="$1" name="$2"
  local color="$GREEN_COLOR" word="PASSED"
  is_dryrun &&
    color="$PINK_COLOR" &&
    word="DRYRUN"

  __print_result "$color" "$word" "$key" "$name" \
    db_get_success_msg db_get_success_log
}
print_disabled() {
  local key="$1" name="$2"
  __print_result "$BLUE_COLOR" "DISABLED" \
    "$key" "$name" "" ""
  db_set_comp_status "$key" "disabled"
}
__print_result() {
  local color="$1" status="$2"
  local key="$3" name="$4"
  local get_msg="$5" get_log="$6" get_err="$7"

  local suffix=""

  local message
  if command -v "$get_msg" >/dev/null; then
    message="$("$get_msg" "$key" "$name")"
    log_debug "get '%s' message: %s" "$name" "$message"

    ## try message from global name
    if [ -z "$message" ]; then
      message="$("$get_msg" "$key")"
      log_debug "get global message: %s" "$message"
    fi
  fi
  [ -n "$message" ] &&
    suffix="$suffix ($message)"

  local outpath
  if command -v "$get_err" >/dev/null; then
    outpath="$("$get_err" "$key" "$name")"
    log_debug "get error path: %s" "$outpath"
  fi
  if [ -z "$outpath" ] && command -v "$get_log" >/dev/null; then
    outpath="$("$get_log" "$key" "$name")"
    log_debug "get log path: %s" "$outpath"
  fi
  [ -n "$outpath" ] &&
    suffix="$suffix [cat $outpath]"

  if is_format_short; then
    logf "$color%s$RESET_COLOR" "${status:0:1}"
  elif is_format_normal; then
    logln "$color%s$RESET_COLOR%s" \
      "$status" "$suffix"
  elif is_format_long; then
    logln "\n  >>> $color%s$RESET_COLOR%s" \
      "$status" "$suffix"
  fi
}

is_format_short() {
  [[ "$FORMAT" == "s" ]] ||
    [[ "$FORMAT" == "m" ]] ||
    [[ "$FORMAT" == "c" ]] ||
    [[ "$FORMAT" == "short" ]] ||
    [[ "$FORMAT" == "mini" ]] ||
    [[ "$FORMAT" == "compack" ]] ||
    [[ "$FORMAT" == "minimize" ]]
}
is_format_normal() {
  [ -z "$FORMAT" ] ||
    [[ "$FORMAT" == "n" ]] ||
    [[ "$FORMAT" == "d" ]] ||
    [[ "$FORMAT" == "normal" ]] ||
    [[ "$FORMAT" == "default" ]]
}
is_format_long() {
  [[ "$FORMAT" == "l" ]] ||
    [[ "$FORMAT" == "v" ]] ||
    [[ "$FORMAT" == "long" ]] ||
    [[ "$FORMAT" == "verbose" ]]
}
is_dryrun() {
  [ -n "$DRYRUN" ]
}
is_debug() {
  [ -n "$DEV_DEBUG" ]
}

log_debug() {
  if is_debug; then
    local output
    output="$(tmp_basepath)"
    __log "DBG" "" "" $'\n' "$@" >>"$output/debug.log"
  fi
}
log_info() {
  if is_format_normal || is_format_long; then
    __log "INF" "" "" $'\n' "$@"
  fi
}
logln() {
  __log "" "" "" $'\n' "$@"
}
logf() {
  __log "" "" "" "" "$@"
}
__log() {
  local _level="$1" _prefix="$2" _suffix="$3" _newline="$4"
  shift 4

  local messages=()
  local args=()

  # local date
  # date="$(date +"%H:%M:%S")"
  # [ -n "$date" ] && messages+=("$date")
  [ -n "$_level" ] && messages+=("[$_level]")
  [ -n "$_prefix" ] && messages+=("$_prefix")
  if [ "$#" -gt 0 ]; then
    messages+=("$1")
    shift
    args+=("$@")
  fi
  [ -n "$_suffix" ] && messages+=("$_suffix")

  # HH:MM:SS [DBG] $_prefix $_format $_suffix

  # shellcheck disable=2059
  printf "${messages[*]}$_newline" "${args[@]}"
}

## get current session directory
tmp_basepath() {
  local base_dir="$_TMPPATH"

  local cache="$base_dir/.fullpath"
  if ! [ -f "$cache" ]; then
    local session_dir="dev-XXXXX"
    mktemp -dq "$base_dir/$session_dir" >"$cache"
  fi

  cat "$cache"
}
tmp_create_dir() {
  local name="$1" dir
  dir="$(tmp_basepath)"
  mktemp -dq "$dir/$name.XX"
}
tmp_create_file() {
  local name="${1:-}" dir
  dir="$(tmp_basepath)"

  local filename=""
  [ -n "$name" ] && filename="$name.XX"
  [ -z "$name" ] && filename="tmp-XXXXXXXX"

  mktemp -q "$dir/$filename"
}
tmp_auto_clean() {
  local tmp="$_TMPPATH"
  local clean_time=.clean.time

  local timestamp="$tmp/$clean_time"
  local fullpath="$tmp/.fullpath"

  log_debug "checking last clean"
  ## Initiate temporary directory
  ! [ -d "$tmp" ] &&
    log_debug "no temporary directory found, create new one" &&
    mkdir -p "$tmp"
  ## Initiate last clean time
  ! [ -f "$timestamp" ] &&
    log_debug "no last clean time found, create new one" &&
    date +"%Y%m%d%H%M%S" >"$timestamp"
  ## Remove full-path file
  [ -f "$fullpath" ] &&
    log_debug "removing fullpath cache" &&
    rm "$fullpath"

  local previous current diff
  previous="$(cat "$timestamp")"
  current="$(date +"%Y%m%d%H%M%S")"
  diff="$((current - previous))"
  log_debug "last cleaning was at %s (diff %d sec)" \
    "$previous" "$diff"
  if [ -d "$tmp" ] && [ "$diff" -gt 3600 ]; then
    log_info "removing temporary directory: %s" "$tmp"
    rm -r "$tmp"
  fi

  ## Create tmp directory if not found
  ! [ -d "$tmp" ] &&
    mkdir -p "$tmp"
}

feat_enabled_git() {
  __feat_enabled git g
}
feat_enabled_prod() {
  __feat_enabled prod pd
}
feat_enabled_prompt() {
  __feat_enabled prompt p
}
feat_enabled_wait() {
  __feat_enabled wait w
}
feat_enabled_single() {
  __feat_enabled single s
}
feat_disabled_test() {
  __feat_disabled test t
}
feat_disabled_list() {
  __feat_disabled list l
}
__feat_enabled() {
  local enable key
  for enable in ${DEV_ENABLED//,/ }; do
    for key in "$@"; do
      if [[ "$key" == "$enable" ]]; then
        return 0
      fi
    done
  done
  return 1
}
__feat_disabled() {
  local disable key
  for disable in ${DEV_DISABLED//,/ }; do
    for key in "$@"; do
      if [[ "$key" == "$disable" ]]; then
        return 1
      fi
    done
  done
  return 0
}

db_set_check_msg() {
  __db_set "checker.msg" "$@"
}
db_get_check_msg() {
  __db_get "checker.msg" "$@"
}
db_set_check_log() {
  __db_set "checker.logpath" "$@"
}
db_get_check_log() {
  __db_get "checker.logpath" "$@"
}
db_set_exec_msg() {
  __db_set "executor.msg" "$@"
}
db_get_exec_msg() {
  __db_get "executor.msg" "$@"
}
db_set_exec_cmd() {
  __db_set "executor.cmd" "$@"
}
db_get_exec_cmd() {
  __db_get "executor.cmd" "$@"
}
db_set_exec_log() {
  __db_set "executor.logpath" "$@"
}
db_get_exec_log() {
  __db_get "executor.logpath" "$@"
}
db_set_exec_err() {
  __db_set "executor.errpath" "$@"
}
db_get_exec_err() {
  __db_get "executor.errpath" "$@"
}
db_set_exec_args() {
  __db_set "executor.arguments" "$@"
}
db_get_exec_args() {
  __db_get "executor.arguments" "$@"
}
db_set_verify_msg() {
  __db_set "verify.msg" "$@"
}
db_get_verify_msg() {
  __db_get "verify.msg" "$@"
}
db_set_verify_log() {
  __db_set "verify.logpath" "$@"
}
db_get_verify_log() {
  __db_get "verify.logpath" "$@"
}
db_set_success_msg() {
  __db_set "success.msg" "$@"
}
db_get_success_msg() {
  __db_get "success.msg" "$@"
}
db_set_success_log() {
  __db_set "success.logpath" "$@"
}
db_get_success_log() {
  __db_get "success.logpath" "$@"
}
db_set_comp_status() {
  __db_set "status" "$@"
}
db_get_comp_status() {
  __db_get "status" "$@"
}
db_set_comp_latest() {
  __db_set "latest" "$@"
}
db_get_comp_latest() {
  __db_get "latest" "$@"
}
db_set_components() {
  __db_set "name" "global" "component" "$@"
}
db_get_components() {
  __db_get "name" "global" "component" "$@"
}
db_set_disabled() {
  __db_set "disabled" "$@"
}
db_get_disabled() {
  __db_get "disabled" "$@"
}
__db_set() {
  local storage
  storage="$(tmp_basepath)/data.txt"

  local namespace="$1" sep="="
  shift

  local _key="$1" _name _value
  if [ "$#" -eq 2 ]; then
    _value="$2"
  elif [ "$#" -ge 3 ]; then
    _name="$2"
    shift 2
    _value="$*"
  fi

  local key="$_key.${_name:-global}.$namespace"
  local value="${_value:-true}"

  ## Caching data on bash variable (memory)
  local __key="${key//./__}" _key
  _key="$(printf '__DB_%s' "${__key//-/_}" | tr '[:lower:]' '[:upper:]')"
  echo "$_key"
  export "$_key"="$value"

  log_debug "saving '%s' ('%s') on storage" "$key" "$value"
  echo "$key$sep$value" >>"$storage"
}
__db_get() {
  local storage
  storage="$(tmp_basepath)/data.txt"

  local namespace="$1" sep="="
  shift

  local _key="$1" _name="${2:-global}"
  local key="$_key.$_name.$namespace"

  ## Fetch from caching first
  local __key="${key//./__}" _key
  _key="$(printf '__DB_%s' "${__key//-/_}" | tr '[:lower:]' '[:upper:]')"
  eval "value=\${$_key}"
  test -n "$value" &&
    printf "%s" "$value" &&
    return 0

  if [ -f "$storage" ]; then
    log_debug "getting '%s' from storage" "$key"
    value="$(grep -E "^$key$sep" "$storage" | tail -n 1)"

    local result="${value#*"$sep"}"
    if [ -n "$result" ]; then
      printf "%s" "$result"
    else
      log_debug "key '%s' is missing from storage (%s)" \
        "$key" "$storage"
    fi
  else
    log_debug "storage file is missing (cannot get '%s')" "$key"
  fi
}

__internal() {
  ! [ -f "$_ROOT/copier.yml" ] &&
    echo "copier.yml not found" >&2 &&
    exit 1
  # shellcheck source=/dev/null
  [ -f "$HOME/.asdf/asdf.sh" ] &&
    source "$HOME/.asdf/asdf.sh"
  tmp_auto_clean

  local cb="$1"
  shift

  local args=("$@")
  if [ "${#args[@]}" -eq 0 ]; then
    args=("${COMPONENTS[@]}")
  fi

  "$cb" "${args[@]}" || exit 1
}
__exit() {
  local code="$_EXIT_CODE"

  local tmpdir
  tmpdir="$(tmp_basepath)"

  logln
  logln "session directory: %s" "$tmpdir"
  logln "data storage: cat %s" "$tmpdir/data.txt"

  unset _ROOT _SCRIPTS _TMPPATH
  unset _EXIT_CODE
  return "$code"
}

export RED_COLOR="\033[0;31m"
export GREEN_COLOR="\033[0;32m"
export BLUE_COLOR="\033[0;34m"
export PINK_COLOR="\033[0;35m"
export CYAN_COLOR='\033[0;36m'
export RESET_COLOR="\e[0m"

export _ROOT="$PWD"
export _SCRIPTS="$_ROOT/scripts"
export _TMPPATH="${TMPDIR:-/tmp}/asdf-plugin-template"

export _EXIT_CODE=0

PATH="$_SCRIPTS/bin:$PATH"

__internal main "$@"

unset COMPONENTS
unset RESET_COLOR \
  RED_COLOR \
  GREEN_COLOR \
  BLUE_COLOR \
  PINK_COLOR \
  CYAN_COLOR

__exit "$_EXIT_CODE"

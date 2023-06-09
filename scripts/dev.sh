#!/usr/bin/env bash

## example: ./scripts/dev.sh argocd
## variables:
##   - $DEV_DEBUG=1                   to enabled debug mode
##   - $DRYRUN=1                      to enabled dryrun mode
##   - $FORMAT=[mini|default|verbose] to custom output format

export COMPONENTS=(
  argocd aws
  cloudflared cmctl cookiecutter
  flux2
  gh git-chglog golang golangci-lint gradle
  helm hub hyperfine
  kind kubectl
  mkcert
  terragrunt
  yamllint
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
  for name in "$@"; do
    plugin_name="asdf-$name"
    plugin_repo="kc-workspace/$plugin_name"

    local_path="$workdir/.temp/$plugin_name"
    plugin_path="$HOME/.asdf/plugins/$name"
    install_path="$HOME/.asdf/installs/$name"

    before_start "$name"
    start "$name" "create-gh-repo" \
      _if_no_gh_repo "$plugin_repo" \
      _exec_silent \
      gh repo create --disable-wiki --public "$plugin_repo" \
      _verify_noop

    addon_path="$local_path/lib/addon"
    start "$name" "remove-addon" \
      _if_dir_exist "$addon_path" \
      _exec_silent \
      rm -r "$addon_path" \
      _verify_noop

    lib_bin_path="$local_path/lib/bin"
    start "$name" "remove-lib-bin" \
      _if_dir_exist "$lib_bin_path" \
      _exec_silent \
      rm -r "$lib_bin_path" \
      _verify_noop

    start "$name" "copier-copy" \
      _if_copier_exist "$local_path" \
      _exec_copier \
      copier copy --UNSAFE \
      --vcs-ref HEAD \
      "$workdir" "$local_path" \
      _verify_noop

    # git add --all
    # git commit -m 'feat(core): applied template'
    # git push origin main

    start "$name" "remove-plugin" \
      _if_dir_exist "$plugin_path" \
      _exec_silent \
      rm -fr "$plugin_path" \
      _verify_noop

    start "$name" "deploy-plugin" \
      _if_no_fail \
      _exec_silent \
      cp -r "$local_path" "$plugin_path" \
      _verify_noop

    start "$name" "get-latest" \
      _if_no_fail \
      _exec_with_errfile \
      asdf latest "$name" \
      _verify_asdf_latest

    local latest
    latest="$(db_get_comp_latest "$name")"

    start "$name" "list-all" \
      _if_no_fail \
      _exec_silent \
      asdf list all "$name" \
      _verify_asdf_list

    DEBUG=1 start "$name" "install-latest" \
      _if_no_fail \
      _exec_silent \
      asdf install "$name" latest \
      _verify_noop

    start "$name" "list-path" \
      _if_no_fail \
      _exec_with_errfile \
      ls -A "$install_path/$latest" \
      _verify_ls "$install_path/$latest"

    start "$name" "list-bin-path" \
      _if_no_fail \
      _exec_with_errfile \
      ls -A "$install_path/$latest/bin" \
      _verify_ls "$install_path/$latest/bin"

    start "$name" "shell-latest" \
      _if_no_fail \
      _exec_silent \
      asdf shell "$name" "$latest" \
      _verify_noop

    start "$name" "test-latest" \
      _if_no_fail \
      _exec_silent \
      asdf "$name" test \
      _verify_output

    DEBUG=1 start "$name" "uninstall-latest" \
      _if_no_fail \
      _exec_silent \
      asdf uninstall "$name" "$latest" \
      _verify_noop

    stop "$name" "$tmpdir"
  done
}

before_start() {
  local key="$1"
  ((COMPONENT_COUNT++))

  if is_format_default; then
    echo
    printf "# $CYAN_COLOR%s$RESET_COLOR\n" "$key"
  elif is_format_mini; then
    printf "%-15s: " "$key"
  fi
}
start() {
  local key="$1" name="$2"
  shift

  print_start "$key" "$name"

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
  print_start_check \
    "$key" "$name" "$checker" "${checker_args[@]}"
  if ! "$checker" "$key" "$name" "${checker_args[@]}"; then
    log_debug "checker '%s' result: skipped" "$key"
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
  print_start_exec \
    "$key" "$name" "$executor" "${executor_args[@]}"
  if ! is_dryrun; then
    if ! "$executor" "$key" "$name" "${executor_args[@]}"; then
      log_debug "executor '%s' result: failed" \
        "$key"
      print_executor_failed "$key" "$name"
      return 0
    fi
  fi

  log_debug "validator '%s[%s]' starting: %s %s" \
    "$key" "$name" "$validator" "${validator_args[*]}"
  print_start_verify \
    "$key" "$name" "$validator" "${validator_args[@]}"
  if ! is_dryrun; then
    if ! "$validator" "$key" "$name" "${validator_args[@]}"; then
      log_debug "validator '%s[%s]' result: failed" \
        "$key" "$name"
      print_validator_failed "$key" "$name"
      return 0
    fi
  fi

  print_success "$key" "$name"
  return 0
}
stop() {
  local key="$1" tmpdir="$2"
  shift 2
  db_set_comp_status "$key" "success"
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
_if_dir_exist() {
  local key="$1" name="$2"
  shift 2

  [ -d "${1:?}" ]
}
_if_copier_exist() {
  local key="$1" name="$2"
  shift 2

  if [ -d "${1:?}" ]; then
    db_set_exec_args "$key" "$name" --overwrite --defaults
  else
    db_set_exec_args "$key" "$name" --overwrite
  fi
}

_exec_silent() {
  local key="$1" name="$2"
  shift 2

  local logfile
  logfile="$(tmp_create_file "$name")"

  log_debug "executor logs: '$logfile'"
  db_set_exec_log "$key" "$name" "$logfile"
  "$@" >"$logfile" 2>&1
}
_exec_prompt() {
  local key="$1" name="$2" args=()
  shift 2

  "$@"
}
_exec_default() {
  local key="$1" name="$2"
  shift 2

  local logfile
  logfile="$(tmp_create_file "$name")"

  log_debug "executor logs: '$logfile'"
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
  db_set_exec_log "$key" "$name" "$logfile"
  if ! "$@" >"$logfile" 2>"$errfile"; then
    log_debug "executor errors: '$errfile'"
    db_set_exec_err "$key" "$name" "$errfile"
    return 1
  fi
}
_exec_copier() {
  local no_prompt
  [[ "$*" =~ --defaults ]] &&
    no_prompt=true

  if [ -n "$no_prompt" ]; then
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

  local logfile size=10
  logfile="$(db_get_exec_log "$key" "$name")"

  if ! [ -f "$logfile" ]; then
    db_set_verify_msg "$key" "$name" "list-all didn't return any version"
    return 1
  fi

  local line=0
  line="$(wc -l <"$logfile" | bc)"
  if [[ "$line" -le $size ]]; then
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
  local key="$1" name="$2"
  shift 2

  if is_format_default; then
    logf '$ %s' "$name"
  fi
}
print_start_check() {
  local key="$1" name="$2" fn="$3"
  shift 3
  return 0
}
print_start_exec() {
  local key="$1" name="$2" fn="$3"
  shift 3

  if is_format_default; then
    logf ' [%s]' "$*"
  fi
}
print_start_verify() {
  # shellcheck disable=SC2034
  local key="$1" name="$2" fn="$3"
  shift 3

  return 0
}
print_checker_failed() {
  local key="$1" name="$2"
  _print_result "$BLUE_COLOR" "SKIPPED" "$key" "$name" \
    "db_get_check_msg" "db_get_check_log"
}
print_executor_failed() {
  local key="$1" name="$2"
  _print_result "$RED_COLOR" "FAILED" "$key" "$name" \
    "db_get_exec_msg" "db_get_exec_log" "db_get_exec_err"
  db_set_comp_status "$key" "failed"
}
print_validator_failed() {
  local key="$1" name="$2"
  _print_result "$RED_COLOR" "FAILED" "$key" "$name" \
    "db_get_verify_msg" "db_get_verify_log"
  db_set_comp_status "$key" "failed"
}
print_success() {
  local key="$1" name="$2"
  local color="$GREEN_COLOR" word="PASSED"
  is_dryrun &&
    color="$PINK_COLOR" &&
    word="DRYRUN"

  _print_result "$color" "$word" "$key" "$name" \
    db_get_success_msg db_get_success_log
}
print_disabled() {
  local key="$1" name="$2"
  _print_result "$BLUE_COLOR" "DISABLED" \
    "$key" "$name" "" ""
  db_set_comp_status "$key" "disabled"
}
_print_result() {
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

  if is_format_default; then
    logln "\n  >>> $color%s$RESET_COLOR%s" "$status" \
      "$suffix"
  elif is_format_mini; then
    logf "$color%s$RESET_COLOR" "${status:0:1}"
  fi
}

is_format_mini() {
  [[ "$FORMAT" == "mini" ]]
}
is_format_default() {
  [ -z "$FORMAT" ] || [[ "$FORMAT" == "default" ]]
}
is_format_verbose() {
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
    __log "DBG" $'\n' "$@" >>"$output/debug.log"
  fi
}
log_info() {
  __log "INF" $'\n' "$@"
}
logln() {
  __log "" $'\n' "$@"
}
logf() {
  __log "" "" "$@"
}
__log() {
  local level="$1" suffix="$2" format="$3"
  shift 3

  if [ -n "$level" ]; then
    printf "[%s] $format$suffix" "$level" "$@"
  else
    # shellcheck disable=2059
    printf "$format$suffix" "$@"
  fi
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
  if [ -f "$storage" ]; then
    log_debug "getting '%s' from storage" "$key"
    local value
    value="$(grep -E "^$key$sep" "$storage" | tail -n 1)"

    local result="${value#*"$sep"}"
    if [ -n "$result" ]; then
      printf "%s" "$result"
    else
      log_debug "key '%s' is missing from storage (%s)" \
        "$key" "$storage"
    fi
  else
    log_debug "storage file is missing"
  fi
}

__internal() {
  ! [ -f "$_ROOT/copier.yml" ] &&
    echo "copier.yml not found" >&2 &&
    exit 1
  # shellcheck source=/dev/null
  [ -f "$HOME/.asdf/asdf.sh" ] &&
    source "$HOME/.asdf/asdf.sh"
  ## Create tmp directory if not found
  ! [ -d "$_TMPPATH" ] &&
    mkdir -p "$_TMPPATH"
  ## Clean fullpath cache
  [ -f "$_TMPPATH/.fullpath" ] &&
    rm "$_TMPPATH/.fullpath"

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

  local tmp="$_TMPPATH"
  local tmpdir
  tmpdir="$(tmp_basepath)"

  local timestamp="$tmp/.cleanup-ts"
  ! [ -f "$timestamp" ] &&
    date +"%Y%m%d%H%M%S" >"$timestamp"

  local previous current diff
  previous="$(cat "$timestamp")"
  current="$(date +"%Y%m%d%H%M%S")"
  diff="$((current - previous))"

  echo
  log_info "session directory: %s" "$tmpdir"
  log_info "data storage: cat %s" "$tmpdir/data.txt"
  if [ -d "$tmp" ] && [ "$diff" -gt 3600 ]; then
    log_info "cleaning temporary directory at %s" "$tmp"
    mv "$tmpdir" "$tmp/.cache-$current" &&
      rm -r "$tmp" &&
      mv "$tmp/.cache-$current" "$tmpdir"
  fi

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

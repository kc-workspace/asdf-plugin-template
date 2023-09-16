#!/usr/bin/env bash

## example: ./scripts/dev.sh [<components>...]
## variables:
##   - $FEAT_ENABLED=debug,dryrun,prod,prompt,deploy,wait,single,test
##         by default all features is disabled:
##         - debug   - enabled debug logs
##         - dryrun  - all execution will only print without executes
##         - prod    - enabled production templates
##         - prompt  - always ask template question (even answer file exist)
##         - deploy  - deploy changes to repository
##         - wait    - wait for workflows (only if enabled deploy)
##         - single  - ask before continue each components
##         - test    - enabled test latest changes first

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

## <component>:[<key>=<value>;]+
export SETTINGS=(
  "1password:size=66;"
  "cookiecutter:size=38;"
  "copier:size=57;"
  "git-chglog:size=14;"
  "go-jsonnet:size=15;"
  "hyperfine:size=23;"
  "jq:size=13;"
  "jsonnet-bundler:size=6;"
  "k6:size=83;"
  "kind:size=32;"
  "maven:size=77;"
  "mkcert:size=14;"
  "pipx:size=55;"
  "yamllint:size=65;"
  ## The last one is default value
  "size=99; commit=perf: update plugin from template [autocommit];"
)

export LIBRARIES=(
  logger temp result color
  feature database setting
  executor runner verifier checker
  core
)

main() {
  local components=("$@")
  if [ "${#components[@]}" -eq 0 ]; then
    components=("${COMPONENTS[@]}")
  fi

  logi "Start script(%s) with %d components" "$_SESSION_ID" "${#components[@]}"
  logln

  db_set_components "${components[@]}"

  local component
  for component in "${components[@]}"; do
    core_start "$component"
  done

  core_summary "${components[@]}"
}

_EXIT_CODE=0
_PATH_CWD="$PWD"
_PATH_SCP="$_PATH_CWD/scripts"
_PATH_TMP_BASE="${TMPDIR:-/tmp}/asdf-plugin-template"
_PATH_TMP=""

_SESSION_ID=""
_INITIATORS=()
_CLEANERS=()

__libs() {
  local name
  for name in "$@"; do
    # shellcheck source=/dev/null
    source "$_PATH_SCP/libs/${name}.sh"
  done
}

__internal() {
  local cb="$1"
  shift

  ! [ -f "$_PATH_CWD/copier.yml" ] && echo "copier.yml not found" >&2 && exit 1
  ## This will allow asdf shell to works properly.
  # shellcheck source=/dev/null
  [ -f "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"

  _PATH_TMP="$(mktemp -dq "$_PATH_TMP_BASE/dev-XXXXX")"
  _SESSION_ID="$(basename "$_PATH_TMP")"

  local init
  for init in "${_INITIATORS[@]}"; do
    "$init"
  done

  "$cb" "$@"
}

__exit() {
  local code="$_EXIT_CODE"

  local clean
  for clean in "${_CLEANERS[@]}"; do
    "$clean"
  done

  unset COMPONENTS SETTINGS LIBRARIES
  unset _EXIT_CODE _PATH_CWD _PATH_SCP _PATH_TMP_BASE
  unset _PATH_TMP _SESSION_ID _INITIATORS _CLEANERS

  return $code
}

__libs "${LIBRARIES[@]}"
__internal main "$@"
__exit

#!/usr/bin/env bash

#= example: ./scripts/dev.sh [<components>...]
#= commands:
#=   - help          - for get help
#=   - list          - for list supported components
#= options:
#=   - -h | --help   - for get help
#=   - -l | --list   - for list supported components
#= variables:
#=   - $FEAT_ENABLED=debug,dryrun,prod,prompt,deploy,wait,single,test
#=         by default all features is disabled:
#=         - debug   - enabled debug logs
#=         - dryrun  - all execution will only print without executes
#=         - prod    - enabled production templates
#=         - prompt  - always ask template question (even answer file exist)
#=         - deploy  - deploy changes to repository
#=         - wait    - wait for workflows (only if enabled deploy)
#=         - test    - enabled test latest changes first
#=         - fast    - enabled fast mode to skipped all slow command

export COMPONENTS=(
  '1password'
  ansible ansible-core argocd aws
  bun
  cloudflared cmctl codecrafters consul cookiecutter copier
  eksctl
  flux2
  gh git-chglog go-jsonnet golang golangci-lint gomplate goreleaser gradle
  helm hub hyperfine
  jq jsonnet-bundler
  k6 kc-tpr kind kops kubeconform kubectl
  maven mkcert
  opentofu operator-sdk
  pipx pomerium
  terraform terragrunt
  yamllint yq
)

## <component>:[<key>=<value>;]+
export SETTINGS=(
  "1password:size=66;"
  "codecrafters:size=32;"
  "cookiecutter:size=38;"
  "copier:size=57;"
  "git-chglog:size=14;"
  "go-jsonnet:size=15;"
  "gomplate:size=64;"
  "hyperfine:size=23;"
  "jq:size=13;"
  "jsonnet-bundler:size=6;"
  "k6:size=83;"
  "kc-tpr:size=8;"
  "kubeconform:size=25;"
  "kind:size=32;"
  "maven:size=77;"
  "mkcert:size=14;"
  "opentofu:size=25;"
  "pipx:size=55;"
  "pomerium:size=17;"
  "yamllint:size=65;"
  ## The last one is default value
  "size=99; commit=perf(plugin): upgrade template to version %s [bot]; branch=main"
)

export LIBRARIES=(
  logger temp result color
  feature database setting
  executor runner verifier checker
  core
)

main() {
  local components=() component

  ## Load components from commandline parameters
  for component in "$@"; do
    cmd_on_help "$component"
    cmd_on_list "$component"

    components+=("$component")
  done

  ## Load default components if no commandline supply
  if [ "${#components[@]}" -eq 0 ]; then
    components=("${COMPONENTS[@]}")
  fi

  local features=()
  feat_is_debug && features+=("debug")
  feat_is_deploy && features+=("deploy")
  feat_is_dryrun && features+=("dry")
  feat_is_prod && features+=("prod")
  feat_is_prompt && features+=("prompt")
  feat_is_test && features+=("test")
  feat_is_wait && features+=("wait")
  feat_is_fast && features+=("fast")

  local suffix=""
  [ "${#features[@]}" -gt 0 ] && suffix=" with features '${features[*]}'"
  logi "Start script(%s) with %d components%s" \
    "$_SESSION_ID" "${#components[@]}" \
    "$suffix"
  logln

  db_set_components "${components[@]}"

  local component
  for component in "${components[@]}"; do
    core_start "$component"
  done

  core_summary "${components[@]}"
}

cmd_on_help() {
  local input="$1"
  if [[ "$input" =~ ^-h ]] || [[ "$input" =~ ^--help ]] || [[ "$input" =~ help ]]; then
    ## Print file header for help
    grep '^#=' "$0" | sed 's/#= //'
    exit 0
  fi
}

cmd_on_list() {
  local input="$1"
  if [[ "$input" =~ ^-l ]] || [[ "$input" =~ ^--list ]] || [[ "$input" =~ list ]]; then
    local component
    echo "Components:"
    for component in "${COMPONENTS[@]}"; do
      printf -- '- %s\n' "$component"
    done
    echo
    exit 0
  fi
}

export _EXIT_CODE=0
export _PATH_CWD="$PWD"
export _PATH_SCP="$_PATH_CWD/scripts"
export _PATH_TMP_BASE="${TMPDIR:-/tmp}/asdf-plugin-template"

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

  ! [ -d "$_PATH_TMP_BASE" ] && mkdir -p "$_PATH_TMP_BASE"
  _PATH_TMP="$(mktemp -dq "$_PATH_TMP_BASE/dev-XXXXX")"
  _SESSION_ID="$(basename "$_PATH_TMP")"

  local init
  for init in "${_INITIATORS[@]}"; do
    "$init" || return 1
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

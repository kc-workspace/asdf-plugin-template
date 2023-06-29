#!/usr/bin/env bash

## example: ./scripts/dev.sh argocd
## variables:
##   - $NO_TEST=1 to disable testing

[ -f "$HOME/.asdf/asdf.sh" ] &&
  source "$HOME/.asdf/asdf.sh"

export COMPONENTS=(
  argocd aws
  cloudflared cmctl
  flux2
  gh git-chglog golang
  helm hub
  kubectl
  terragrunt
)

export GREEN_COLOR="\e[32m"
export RED_COLOR="\e[31m"
export BLUE_COLOR="\e[36m"
export RESET_COLOR="\e[0m"
export PASSED="${GREEN_COLOR}passed${RESET_COLOR}"
export FAILED="${RED_COLOR}failed${RESET_COLOR}"

main() {
  local template="$PWD"

  local name temp plugin
  local latest latest_logs

  for name in "$@"; do
    temp="$template/.temp/asdf-$name"
    plugin="$HOME/.asdf/plugins/$name"

    printf "# $BLUE_COLOR%s$RESET_COLOR\n" "$name"

    if [ -d "$temp" ]; then
      step exec_default check_noop \
        copier copy \
        --vcs-ref HEAD \
        --UNSAFE \
        "$template" "$temp" \
        --defaults --overwrite ||
        break
    else
      step exec_prompt check_noop \
        copier copy \
        --vcs-ref HEAD \
        --UNSAFE \
        "$template" "$temp" \
        --overwrite ||
        break
    fi
    step exec_default check_noop \
      rm -rf "$plugin" ||
      break
    step exec_default check_noop \
      cp -r "$temp" "$plugin" ||
      break

    test -n "$NO_TEST" &&
      echo &&
      continue

    latest_logs="$(mktemp -t latest)"
    latest="$(asdf latest "$name" 2>"$latest_logs")"
    [ -z "$latest" ] &&
      print_status "$FAILED" "latest is required [cat $latest_logs]" &&
      break

    step exec_sep_logs check_asdf_list \
      asdf list all "$name" ||
      break
    DEBUG=1 step exec_default check_noop \
      asdf install "$name" latest ||
      break
    DEBUG=1 step exec_default check_noop \
      asdf uninstall "$name" "$latest" ||
      break
    step exec_default check_noop \
      asdf install "$name" "$latest" ||
      break
    step exec_default check_ls \
      ls -A "$HOME/.asdf/installs/$name/$latest"
    step exec_default check_ls \
      ls -A "$HOME/.asdf/installs/$name/$latest/bin"
    step exec_default check_noop \
      asdf shell "$name" "$latest" ||
      break
    step exec_default check_noop \
      asdf "$name" test ||
      break
    step exec_default check_noop \
      asdf uninstall "$name" "$latest" ||
      break
    echo
  done
}

step() {
  local exec="${1:?}" check="${2:?}"
  local cmd="$3" arg="$4"
  shift 4

  local logs errs
  logs="$(mktemp -t "$cmd-$arg")"
  errs="$logs.err"

  printf '$ %-40s\n' "$cmd $arg $*"
  if "$exec" "$logs" "$errs" "$cmd" "$arg" "$@"; then
    if "$check" "$logs" "$errs"; then
      return 0
    fi
  fi

  ## fail-fast
  return 1
}

exec_default() {
  local logs="$1" errs="$2"
  shift 2

  if ! "$@" >"$logs" 2>&1; then
    print_status "$FAILED" "[cat $logs]"
    return 1
  fi
}

exec_prompt() {
  local logs="$1" errs="$2"
  shift 2

  if ! "$@"; then
    print_status "$FAILED" "[cat $logs]"
    return 1
  fi
}

exec_sep_logs() {
  local logs="$1" errs="$2"
  shift 2

  if ! "$@" >"$logs" 2>"$errs"; then
    print_status "$FAILED" "[cat $errs]"
    return 1
  fi
}

check_noop() {
  local logs="$1" errs="$2"
  print_status "$PASSED" "[cat $logs]"
}

check_asdf_list() {
  local size=10
  local logs="$1" errs="$2"

  local line=0
  line="$(wc -l <"$logs" | bc)"
  if [[ "$line" -gt $size ]]; then
    print_status "$PASSED" "(size=$line) [cat $logs]"
    return 0
  fi

  print_status "$FAILED" "(size=$line<$size) [cat $errs]"
  return 1
}

check_ls() {
  local logs="$1" errs="$2"
  print_status "$PASSED" "[$(xargs echo <"$logs")]"
  rm "$logs" "$errs" >/dev/null 2>&1
}

print_status() {
  local status="$1" message="$2"
  printf "  >> $status %s\n" "$message"
}

__internal() {
  ! [ -f "$PWD/copier.yml" ] &&
    echo "copier.yml not found" >&2 &&
    exit 1

  local cb="$1"
  shift

  local args=("$@")
  if [ "${#args[@]}" -eq 0 ]; then
    args=("${COMPONENTS[@]}")
  fi

  "$cb" "${args[@]}"
}

__internal main "$@"

unset COMPONENTS
unset GREEN_COLOR RED_COLOR RESET_COLOR
unset PASSED FAILED

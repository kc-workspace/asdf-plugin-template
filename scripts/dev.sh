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
  gh git-chglog golang golangci-lint gradle
  helm hub
  kind kubectl
  mkcert
  terragrunt
  yamllint
)

export GREEN_COLOR="\e[32m"
export RED_COLOR="\e[31m"
export BLUE_COLOR="\e[36m"
export RESET_COLOR="\e[0m"
export PASSED="${GREEN_COLOR}passed${RESET_COLOR}"
export FAILED="${RED_COLOR}failed${RESET_COLOR}"

main() {
  local template="$PWD"
  local deployed_file
  deployed_file="$(on_deploy)"

  local name plugin_name
  local temp plugin
  local latest latest_logs
  local failed_count=0

  for name in "$@"; do
    plugin_name="asdf-$name"
    temp="$template/.temp/$plugin_name"
    plugin="$HOME/.asdf/plugins/$name"

    printf "# $BLUE_COLOR%s$RESET_COLOR\n" "$name"

    if test -n "$deployed_file"; then
      if ! grep -qiE "^$plugin_name$" "$deployed_file"; then
        step exec_default check_noop \
          gh repo create --disable-wiki \
          "kc-workspace/$plugin_name" --public || {
          ((failed_count++))
          continue
        }
      fi
    fi
    if [ -d "$temp" ]; then
      ## Manually delete addon before copy template
      if [ -d "$temp/lib/addon" ]; then
        step exec_default check_noop \
          rm -r "$temp/lib/addon" || {
          ((failed_count++))
          continue
        }
      fi
      ## Manually delete lib/bin before copy template
      if [ -d "$temp/lib/bin" ]; then
        step exec_default check_noop \
          rm -r "$temp/lib/bin" || {
          ((failed_count++))
          continue
        }
      fi
      step exec_default check_noop \
        copier copy \
        --vcs-ref HEAD \
        --UNSAFE \
        "$template" "$temp" \
        --overwrite --defaults || {
        ((failed_count++))
        continue
      }
    else
      step exec_prompt check_noop \
        copier copy \
        --vcs-ref HEAD \
        --UNSAFE \
        "$template" "$temp" \
        --overwrite || {
        ((failed_count++))
        continue
      }
    fi
    step exec_default check_noop \
      rm -rf "$plugin" || {
      ((failed_count++))
      continue
    }
    step exec_default check_noop \
      cp -r "$temp" "$plugin" || {
      ((failed_count++))
      continue
    }

    { test -n "$NO_TEST" || test -n "$deployed_file"; } &&
      echo &&
      continue

    print_header "asdf" "latest" "$name"
    latest_logs="$(mktemp -t latest)"
    latest="$(asdf latest "$name" 2>"$latest_logs")"
    if [ -n "$latest" ]; then
      print_status "$PASSED" "(latest=$latest)"
    else
      print_status "$FAILED" "latest is required [cat $latest_logs]"
      ((failed_count++))
      continue
    fi

    step exec_sep_logs check_asdf_list \
      asdf list all "$name" || {
      ((failed_count++))
      continue
    }
    DEBUG=1 step exec_default check_noop \
      asdf install "$name" latest || {
      ((failed_count++))
      continue
    }
    DEBUG=1 step exec_default check_noop \
      asdf uninstall "$name" "$latest" || {
      ((failed_count++))
      continue
    }
    step exec_default check_noop \
      asdf install "$name" "$latest" || {
      ((failed_count++))
      continue
    }
    step exec_default check_ls \
      ls -A "$HOME/.asdf/installs/$name/$latest" || {
      ((failed_count++))
      continue
    }
    step exec_default check_ls \
      ls -A "$HOME/.asdf/installs/$name/$latest/bin" || {
      ((failed_count++))
      continue
    }
    step exec_default check_noop \
      asdf shell "$name" "$latest" || {
      ((failed_count++))
      continue
    }
    step exec_sep_logs check_test \
      asdf "$name" test || {
      ((failed_count++))
      continue
    }
    step exec_default check_noop \
      asdf uninstall "$name" "$latest" || {
      ((failed_count++))
      continue
    }
    echo
  done

  if [ "$failed_count" -gt 0 ]; then
    printf "task has been failed %d times\n" "$failed_count" >&2
    echo
    return 1
  fi
}

step() {
  local exec="${1:?}" check="${2:?}"
  local cmd="$3" arg="$4"
  shift 4

  local logs errs
  logs="$(mktemp -t "$cmd-$arg")"
  errs="$logs.err"

  print_header "$cmd" "$arg" "$*"
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
    echo
    return 1
  fi
}

exec_prompt() {
  local logs="$1" errs="$2"
  shift 2

  if ! "$@"; then
    print_status "$FAILED" "[cat $logs]"
    echo
    return 1
  fi
}

exec_sep_logs() {
  local logs="$1" errs="$2"
  shift 2

  if ! "$@" >"$logs" 2>"$errs"; then
    print_status "$FAILED" "[cat $errs]"
    echo
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
  echo
  return 1
}

check_ls() {
  local logs="$1" errs="$2"
  print_status "$PASSED" "[$(xargs echo <"$logs")]"
  rm "$logs" "$errs" >/dev/null 2>&1
  return 0
}

check_test() {
  local logs="$1" errs="$2"
  print_status "$PASSED" "($(cat "$logs"))"
}

print_header() {
  printf '$ %s\n' "$*"
}

print_status() {
  local status="$1" message="$2"
  printf "  >> $status %s\n" "$message"
}

on_deploy() {
  test -z "$DEPLOY" &&
    return 0

  local temp
  temp="$(mktemp)"
  gh repo list kc-workspace --visibility public --json name --jq '.[].name' >"$temp"
  printf "%s" "$temp"
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

  "$cb" "${args[@]}" || exit 1
}

__internal main "$@"

unset COMPONENTS
unset GREEN_COLOR RED_COLOR RESET_COLOR
unset PASSED FAILED

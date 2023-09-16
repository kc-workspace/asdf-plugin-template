#!/usr/bin/env bash

core_start() {
  local component="$1"

  local plugin_name="asdf-$component"
  local plugin_repo="kc-workspace/$plugin_name"

  local local_path="$_PATH_CWD/.temp/$plugin_name"
  local plugin_path="$HOME/.asdf/plugins/$component"
  local install_path="$HOME/.asdf/installs/$component"

  runner_start "$component"

  runner "$component" create-gh-repo \
    $ check_cmd_fail gh repo view "$plugin_repo" --json 'name' \
    $ exec_with_file gh repo create --disable-wiki --public "$plugin_repo"

  runner "$component" remove-addon \
    $ check_dir_exist "$local_path/lib/addon" \
    $ exec_with_file rm -r "$local_path/lib/addon"

  # addon_path="$local_path/lib/addon"
  # step "$name" "remove-addon" \
  #   _if_dir_exist "$addon_path" \
  #   _exec_silent \
  #   rm -r "$addon_path" \
  #   _verify_noop

  runner_summary "$component"
}

core_summary() {
  local components=("$@")

  result_summary_start
  for component in "${components[@]}"; do
    local steps=() step
    # shellcheck disable=SC2207
    steps=($(db_get_comp_steps "$component"))
    for step in "${steps[@]}"; do
      result_summary_comp_step "$component" "$step"
    done
  done
}

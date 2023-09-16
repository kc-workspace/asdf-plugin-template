#!/usr/bin/env bash

core_start() {
  local component="$1"

  local plugin_name="asdf-$component"
  local plugin_repo="kc-workspace/$plugin_name"
  local plugin_repo_url="https://github.com/$plugin_repo.git"

  local local_path="$_PATH_CWD/.temp/$plugin_name"
  local plugin_path="$HOME/.asdf/plugins/$component"
  local install_path="$HOME/.asdf/installs/$component"

  runner_start "$component"

  runner "$component" create-gh-repo \
    $ check_cmd_fail gh repo view "$plugin_repo" --json 'name' \
    $ exec_with_file gh repo create "$plugin_repo" --disable-wiki --public

  runner "$component" update-gh-repo \
    $ check_must_success create-gh-repo \
    $ exec_with_logfile gh repo edit "$plugin_repo" \
    --add-topic asdf --add-topic asdf-plugin --add-topic asdf-vm \
    --delete-branch-on-merge --enable-auto-merge \
    --enable-issues --allow-update-branch \
    --enable-discussions=false --enable-projects=false --enable-wiki=false \
    --enable-rebase-merge=false

  runner "$component" remove-addon \
    $ check_dir_exist "$local_path/lib/addon" \
    $ exec_with_file rm -r "$local_path/lib/addon"

  runner "$component" remove-lib-bin \
    $ check_dir_exist "$local_path/lib/bin" \
    $ exec_with_file rm -r "$local_path/lib/bin"

  runner "$component" copier-copy \
    $ exec_copier "$local_path"

  runner "$component" git-init \
    $ check_no_errors \
    $ check_dir_missing "$local_path/.git" \
    $ exec_with_file git -C "$local_path" init

  runner "$component" git-remote-add \
    $ check_no_errors \
    $ check_cmd_fail git -C "$local_path" remote show origin \
    $ exec_with_file git -C "$local_path" remote add origin "$plugin_repo_url"

  runner "$component" clean-plugin \
    $ check_no_errors \
    $ check_dir_exist "$plugin_path" \
    $ exec_with_file rm -fr "$plugin_path"

  runner "$component" deploy-plugin \
    $ check_no_errors \
    $ check_must_success copier-copy \
    $ check_dir_exist "$local_path" \
    $ exec_with_file cp -r "$local_path" "$plugin_path"

  runner "$component" get-latest \
    $ check_must_success deploy-plugin \
    $ exec_with_file asdf latest "$component" \
    $ verify_asdf_latest

  local latest
  latest="$(db_get_comp_latest "$component")"

  runner "$component" list-all \
    $ check_must_success deploy-plugin \
    $ exec_with_file asdf list all "$component" \
    $ verify_asdf_list

  runner "$component" install-latest \
    $ check_cmd_pass feat_is_test \
    $ exec_with_file asdf install "$component" latest \
    $ verify_asdf_install "$install_path"

  runner "$component" shell-latest \
    $ check_must_success get-latest \
    $ check_cmd_pass feat_is_test \
    $ exec_with_file asdf shell "$component" "$latest"

  runner "$component" "test-latest" \
    $ check_cmd_pass feat_is_test \
    $ exec_with_file asdf "$component" test

  runner "$component" "uninstall-latest" \
    $ check_must_success get-latest \
    $ check_cmd_pass feat_is_test \
    $ exec_with_file asdf uninstall "$component" "$latest"

  runner "$component" "git-pull" \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" pull origin main

  runner "$component" "git-add-all" \
    $ check_cmd_fail git diff --exit-code main \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" add --all

  runner "$component" "git-commit" \
    $ check_must_success git-add-all \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" commit -m "$(setting "$component" commit)"

  runner "$component" "git-push" \
    $ check_must_success git-commit \
    $ check_cmd_fail git -C "$local_path" diff --exit-code origin/main..main \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" push origin main

  runner "$component" "wait-workflow" \
    $ check_must_success git-push \
    $ check_cmd_pass feat_is_wait \
    $ exec_gh_actions_watch "$plugin_repo"

  runner_summary "$component"
}

core_summary() {
  local components=("$@")

  result_summary_start
  for component in "${components[@]}"; do
    result_summary_comp_start "$component"

    local steps=() step
    # shellcheck disable=SC2207
    steps=($(db_get_comp_steps "$component"))
    for step in "${steps[@]}"; do
      result_summary_comp_step "$component" "$step"
    done
  done
}

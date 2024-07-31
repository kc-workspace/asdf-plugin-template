#!/usr/bin/env bash

core_start() {
  local component="$1"

  local plugin_name="asdf-$component"
  local plugin_repo="kc-workspace/$plugin_name"
  local plugin_branch="main"
  local plugin_repo_url="https://github.com/$plugin_repo.git"

  local local_path="$_PATH_CWD/.temp/$plugin_name"
  local plugin_path="$HOME/.asdf/plugins/$component"
  local install_path="$HOME/.asdf/installs/$component"

  local branch
  branch="$(setting "$component" branch)"

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
    --enable-rebase-merge=false # --default-branch "$plugin_branch"

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
    $ exec_with_file git -C "$local_path" init --initial-branch "$plugin_branch"

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
    $ check_cmd_fail feat_is_dryrun \
    $ check_cmd_fail feat_is_fast \
    $ check_must_success deploy-plugin \
    $ exec_with_file asdf latest "$component" \
    $ verify_asdf_latest

  runner "$component" list-all \
    $ check_must_success get-latest deploy-plugin \
    $ check_cmd_fail feat_is_fast \
    $ exec_with_file asdf list all "$component" \
    $ verify_asdf_list

  ## The asdf plugin test only works if your plugin has been deployed to github
  ## otherwise, it won't works because it cannot download plugin from github
  # runner "$component" plugin-test \
  #   $ check_must_success get-latest deploy-plugin \
  #   $ check_cmd_pass feat_is_test \
  #   $ exec_with_file asdf plugin test "$component" "$plugin_repo_url" \
  #   --asdf-plugin-gitref "$plugin_branch" asdf "$component" test

  local latest
  latest="$(db_get_comp_latest "$component")"
  runner "$component" install-latest \
    $ check_must_success get-latest \
    $ check_cmd_pass feat_is_test \
    $ check_cmd_fail feat_is_fast \
    $ exec_with_file asdf install "$component" latest \
    $ verify_asdf_install "$install_path"
  runner "$component" shell-latest \
    $ check_must_success get-latest \
    $ check_must_success install-latest \
    $ check_cmd_pass feat_is_test \
    $ check_cmd_fail feat_is_fast \
    $ exec_with_file asdf shell "$component" "$latest"
  runner "$component" "test-latest" \
    $ check_must_success get-latest \
    $ check_must_success install-latest \
    $ check_cmd_pass feat_is_test \
    $ check_cmd_fail feat_is_fast \
    $ exec_with_file asdf "$component" test
  runner "$component" "uninstall-latest" \
    $ check_must_success get-latest \
    $ check_must_success install-latest \
    $ check_cmd_pass feat_is_test \
    $ check_cmd_fail feat_is_fast \
    $ exec_with_file asdf uninstall "$component" "$latest"

  runner "$component" "git-pull" \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" pull origin "$branch"

  runner "$component" "git-add-all" \
    $ check_cmd_fail git -C "$local_path" diff --exit-code "$branch" \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" add --all

  local commit_message template_version
  template_version="$(__exec yq --unwrapScalar --expression '._commit' "$local_path/.copier-answers.yml")"
  # shellcheck disable=SC2059
  printf -v commit_message "$(setting "$component" commit)" "$template_version"
  runner "$component" "git-commit" \
    $ check_must_success git-add-all \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" commit -m "$commit_message"

  runner "$component" "git-set-upstream" \
    $ check_must_success git-add-all \
    $ exec_ignore git -C "$local_path" branch --set-upstream-to "origin/$branch" "$branch"

  runner "$component" "git-push" \
    $ check_must_success git-commit \
    $ check_cmd_fail git -C "$local_path" diff --exit-code "origin/$branch..$branch" \
    $ check_cmd_pass feat_is_deploy \
    $ exec_ignore git -C "$local_path" push --set-upstream origin "$branch"

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

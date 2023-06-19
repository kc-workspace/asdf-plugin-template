#!/usr/bin/env bash

## Environment variables
## https://asdf-vm.com/plugins/create.html#environment-variables-overview

# shellcheck source-path=SCRIPTDIR/common/index.sh
source "${ASDF_PLUGIN_PATH:?}/lib/common/index.sh"

if command -v kc_asdf_main >/dev/null; then
  kc_asdf_main ||
    kc_asdf_throw "main function failed"
else
  case "$1" in
  download) __asdf_bin_download ;;
  help-config) __asdf_bin_help-config ;;
  help-deps) __asdf_bin_help-deps ;;
  help-links) __asdf_bin_help-links ;;
  help-overview) __asdf_bin_help-overview ;;
  install) __asdf_bin_install ;;
  latest) __asdf_bin_latest ;;
  list-all) __asdf_bin_list-all ;;
  esac
fi

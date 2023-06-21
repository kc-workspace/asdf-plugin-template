#!/usr/bin/env bash

## Environment variables
## https://asdf-vm.com/plugins/create.html#environment-variables-overview

# shellcheck source-path=SCRIPTDIR/utils.sh
source "${KC_ASDF_PLUGIN_PATH:?}/lib/utils.sh"
# shellcheck source-path=SCRIPTDIR/common/index.sh
source "${KC_ASDF_PLUGIN_PATH:?}/lib/common/index.sh"

kc_asdf_debug "executing '%s' script: arguments [%s]" \
  "$KC_ASDF_PLUGIN_ENTRY_NAME" "$*"

if command -v kc_asdf_main >/dev/null; then
  kc_asdf_debug "use main function on %s script instead" \
    "$KC_ASDF_PLUGIN_ENTRY_NAME"
  kc_asdf_main ||
    kc_asdf_throw 99 "main function failed"
else
  path="${KC_ASDF_PLUGIN_PATH:?}/lib/bin/${KC_ASDF_PLUGIN_ENTRY_NAME//./-}.sh"
  kc_asdf_debug "sourcing lib: %s" \
    "$path"

  # shellcheck source=/dev/null
  source "$path" ||
    __asdf_bin_unknown "${KC_ASDF_PLUGIN_ENTRY_NAME:?}"
  __asdf_bin "$@"
fi

unset name args

# Contributors

Thank you for investing your time in contributing to our project!

## Golden rules for contributing

> [asdf-golden-rules][asdf-golden-rules]

1. Only `bin/*` and `lib/utils.sh` are open for modify
2. There several functions available on bin/* script [bin/README.md]
3. The function defined on `lib/utils.sh` will be available everywhere
4. Scripts should NOT call other asdf commands
5. Keep your dependency list of Shell tools/commands small
6. avoid non-portable tools or command flags. ([banned-commands][banned-commands])
7. New create `bin/*` script should use below template as starter

```bash
#!/usr/bin/env bash

## <description>
## https://asdf-vm.com/plugins/create.html

## -----------------------
## Customization functions

kc_asdf_main() {
  return 0
}

## -----------------------

set -euo pipefail

export KC_ASDF_PLUGIN_ENTRY_PATH=${BASH_SOURCE[0]}
export KC_ASDF_PLUGIN_ENTRY_NAME
KC_ASDF_PLUGIN_ENTRY_NAME="$(basename "$KC_ASDF_PLUGIN_ENTRY_PATH")"
export KC_ASDF_PLUGIN_PATH
KC_ASDF_PLUGIN_PATH=$(dirname "$(dirname "$KC_ASDF_PLUGIN_ENTRY_PATH")")

# shellcheck source-path=SCRIPTDIR/../lib/commands.sh
source "$KC_ASDF_PLUGIN_PATH/lib/commands.sh" "$@"
```

## Scripts

> [asdf overview][asdf-overview]

There are several callbacks allow to customize script
without touching built-in utilities.

## Generic scripts callback

This listed custom function that can defined on any bin/* scripts.

1. To customize functionality of script (without use any default logic), use `kc_asdf_main()`

```bash
## Example code of kc_asdf_main function
kc_asdf_main() {
  return 0
}
```

## Generic utilities callback

This listed custom function that should defined on **lib/utils.sh**.
To custom some default configuration.

1. To custom final OS name, use `_kc_asdf_custom_os()`

```bash
_kc_asdf_custom_os() {
  local os="$1"
  printf "%s" "$os"
}
```

2. To custom final ARCH name, use `_kc_asdf_custom_arch()`

```bash
_kc_asdf_custom_arch() {
  local arch="$1"
  printf "%s" "$arch"
}
```

3. To custom environment variables, use `_kc_asdf_custom_env()`

```bash
## If this return error, it will only log warning message
## and continue program
_kc_asdf_custom_env() {
  kc_asdf_is_darwin &&
    export ASDF_INSECURE=true
  return 0
}
```

4. To custom enable-disable features, use `_kc_asdf_custom_enabled_features()`

```bash
## If this return error, mean that feature is disabled
_kc_asdf_custom_enabled_features() {
  ## feature name: checksum, gpg
  local feature="$1"
  return 0
}
```

## List all callback

1. To filter value from list, use `_kc_asdf_custom_filter()`.

```bash
_kc_asdf_custom_filter() {
  local tmpfile="$1"
  ## Select only version prefix 1
  kc_asdf_tags_only "$tmpfile" "1"
}
```

## Latest stable callback

1. To filter value from list, use `_kc_asdf_custom_filter()`.

```bash
_kc_asdf_custom_filter() {
  local tmpfile="$1" query="$2"
  ## Filter based on user input query
  ## You don't need to as it implemented on default
  kc_asdf_tags_only "$tmpfile" "$query"
}
```

## Download callback

1. To support generate checksum file, use `_kc_asdf_custom_checksum()`

```bash
_kc_asdf_custom_checksum() {
  ## filename is app file to check
  local filename="$1"
  ## checksum_tmp is a raw checksum file from url
  local checksum_tmp="$2"
  ## checksum_path is a output normalize checksum file
  local checksum_path="$3"
}
```

2. To support custom download URL, use `_kc_asdf_custom_download_url()`

```bash
## printf empty string will indicate there are a problem
_kc_asdf_custom_download_url() {
  local version="$1" old_url="$2"
  printf "%s" "$old_url"
}
```

3. To support custom version before download, use `_kc_asdf_custom_version()`

```bash
_kc_asdf_custom_version() {
  local version="$1"
  printf "%s" "$version"
}
```

4. To support custom source URL, use `_kc_asdf_custom_source_url()`

```bash
## printf empty string will indicate there are a problem
_kc_asdf_custom_source_url() {
  local version="$1" old_url="$2"
  printf "%s" "$old_url"
}
```

5. To support download source code, use `_kc_asdf_custom_download_source()`

```bash
## This will required _kc_asdf_install_source to defined too
## when `asdf install plugin ref:main`
_kc_asdf_custom_download_source() {
  local version="$1" download_url="$2"
  local download_path="$3"
}
```

6. To support action after downloaded, use `_kc_asdf_custom_post_download()`

```bash
## type can be either 'version' or 'ref'
## version is downloaded version
## result is downloaded directory
_kc_asdf_custom_post_download() {
  local type="$1" version="$2"
  local output="$3"
}
```

## Install callback

1. To support custom build source code, use `_kc_asdf_custom_source_build()`

```bash
## current directory will be at source code directory
_kc_asdf_custom_source_build() {
  local version="$1" output="$2"
  local concurrency="$3"
}
```

## Parse legacy file callback

1. To support parsing legacy version, use `_kc_asdf_custom_parse_version_file()`

```bash
_kc_asdf_custom_parse_version_file() {
  local filepath="$1"
  cat "$filepath"
}
```

## Help overview

1. To override overview message, use `_kc_asdf_custom_help()`

```bash
_kc_asdf_custom_help() {
  printf "this is a override overview help"
}
```

## Help config

1. To override config message, use `_kc_asdf_custom_help()`

```bash
_kc_asdf_custom_help() {
  printf "this is a override config help"
}
```

## Help dependencies

1. To override dependencies message, use `_kc_asdf_custom_help()`

```bash
_kc_asdf_custom_help() {
  local add_deps="$1"
  add_deps "asdf" "curl" "echo"
}
```

## Help links

1. To override links message, use `_kc_asdf_custom_help()`

```bash
_kc_asdf_custom_help() {
  local new_link="$1"
  new_link "Name" "https://example.com"
}
```

<!-- LINKS SECTION -->

[asdf-golden-rules]: https://asdf-vm.com/plugins/create.html#golden-rules-for-plugin-scripts
[asdf-overview]: https://asdf-vm.com/plugins/create.html#scripts-overview
[banned-commands]: https://github.com/asdf-vm/asdf/blob/master/test/banned_commands.bats

# Script bin

> https://asdf-vm.com/plugins/create.html#scripts-overview

## Golden Rules for Plugin Scripts

1. scripts should NOT call other asdf commands
2. keep your dependency list of Shell tools/commands small
3. avoid non-portable tools or command flags. For example, sort -V. See our asdf core list of banned commands

> https://asdf-vm.com/plugins/create.html#golden-rules-for-plugin-scripts

## Generic script

All scripts have optional to implement it's own functionality
using `kc_asdf_main` function

```bash
## Example code of kc_asdf_main function
kc_asdf_main() {
  return 0
}
```

## List all

1. To filter value from list, use `_kc_asdf_list_filter()`.

```bash
_kc_asdf_list_filter() {
  local tmpfile="$1"
  ## Select only version prefix 1
  kc_asdf_tags_only "$tmpfile" "1"
}
```

## Latest stable

1. To filter value from list, use `_kc_asdf_list_filter()`.

```bash
_kc_asdf_latest_filter() {
  local tmpfile="$1" query="$2"
  ## Filter based on user input query
  ## You don't need to as it implemented on default
  kc_asdf_tags_only "$tmpfile" "$query"
}
```

## Install

1. To support install from source code, use `_kc_asdf_install_source()`

```bash
## This will required _kc_asdf_download_source to defined too
## when `asdf install plugin ref:main`
_kc_asdf_install_source() {
  local version="$1"
  local download_path="$2" install_path="$3"
  local concurrency="$4"
}
```

## Download

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

2. To support download source code, use `_kc_asdf_download_source()`

```bash
## This will required _kc_asdf_install_source to defined too
## when `asdf install plugin ref:main`
_kc_asdf_download_source() {
  local version="$1"
  local download_path="$2"
}
```

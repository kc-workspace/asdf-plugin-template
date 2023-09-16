#!/usr/bin/env bash

_C_RED="\033[0;31m"
_C_GREEN="\033[0;32m"
_C_BLUE="\033[0;34m"
_C_PINK="\033[0;35m"
_C_CYAN='\033[0;36m'
_C_RESET="\e[0m"

__color_cleanup() {
  unset _C_RED _C_GREEN _C_BLUE _C_PINK _C_CYAN _C_RESET
}
_CLEANERS+=(__color_cleanup)

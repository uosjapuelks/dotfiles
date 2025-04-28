#!/bin/bash
set -ex
# set -u
set -o pipefail

if [[ $1 ]]; then
# Ubuntu24 swap caps and ctrl
  gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
else
# Ubuntu24 RESET SWAP
  gsettings reset org.gnome.desktop.input-sources xkb-options
fi

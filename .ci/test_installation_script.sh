#!/bin/bash

set -e

DIRECTORY="$(dirname "$0")"
SHELL_TO_RUN="$1"
PROFILE_FILE="$("$DIRECTORY/get_shell_profile.sh" "$SHELL_TO_RUN")"

ls -lah ~
echo "Profile is $PROFILE_FILE"
cat ~/.bashrc

fnm --version

$SHELL_TO_RUN -c '
  fnm install 12.5.0
  fnm ls | grep 12.5.0

  echo "fnm ls worked."
'

$SHELL_TO_RUN -c '
  fnm use 12.5.0
  node --version | grep 12.5.0

  echo "node --version worked."
'

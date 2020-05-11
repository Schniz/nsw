#!/bin/bash

set -e

eval "$(fnm env --multi)"

if [ "$(fnm current)" != "none" ]; then
  echo "Expected currently activated version is not none!"
  exit 1
fi

fnm install v8.11.3
fnm use v8.11.3

if [ "$(fnm current)" != "v8.11.3" ]; then
  echo "Expected currently activated version is not v8.11.3!"
  exit 1
fi

fnm use system

if [ "$(fnm current)" != "system" ]; then
  echo "Expected currently activated version is not system!"
  exit 1
fi

fnm install v10.10.0
fnm use v10.10.0

if [ "$(fnm current)" != "v10.10.0" ]; then
  echo "Expected currently activated version is not v10.10.0!"
  exit 1
fi

fnm uninstall v10.10.0

if [ "$(fnm current)" != "system" ]; then
  echo "Expected currently activated version is not system!"
  exit 1
fi

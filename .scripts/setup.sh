#!/usr/bin/env sh
# Copyright 2019-2021 Tauri Programme within The Commons Conservancy
# SPDX-License-Identifier: Apache-2.0
# SPDX-License-Identifier: MIT

set -ex

echo "Building API definitions..."
cd tooling/api
yarn && yarn build
cd ../..

echo "Building the Tauri Rust CLI..."
cd tooling/cli.rs
cargo install --path .
cd ../..
echo "Tauri Rust CLI installed. Run it with '$ cargo tauri [COMMAND]'."

function installNodeJsCli() {
  cd tooling/cli.js
  yarn && yarn build && yarn link
  cd ../..
  echo "Tauri Node.js CLI installed. Run it with '$ tauri [COMMAND]'."
}

if [ -z "$PS1" ]; then
  installNodeJsCli
else
  echo "Do you want to install the Node.js CLI?"
  select yn in "Yes" "No"; do
    case $yn in
    Yes)
      installNodeJsCli
      break
      ;;
    No) break ;;
    esac
  done
fi

#!/bin/bash
set -ex

echo "--- yarn"
yarn
echo "--- clone nxpkg/nxpkg"
CONFIG_DIR=$(pwd)
CLONE_DIR=$(mktemp -d)
git clone --depth 1 https://github.com/nxpkg/nxpkg "$CLONE_DIR"
cd "$CLONE_DIR"
mkdir -p annotations
echo "--- yarn"
yarn --frozen-lockfile
echo "--- yarn add"
yarn add --dev "$CONFIG_DIR"
yarn deduplicate
yarn
echo "--- diff"
git diff
echo "--- generate"
yarn generate
echo "--- build-ts"
yarn build-ts
echo "--- eslint"
yarn lint:js:all

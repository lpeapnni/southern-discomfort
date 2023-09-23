#!/bin/bash
set -euo pipefail

source dependencies.sh

export NODE_OPTIONS=--openssl-legacy-provider

if [[ -e ~/.nvm/nvm.sh ]]; then
	source ~/.nvm/nvm.sh
	nvm install $NODE_VERSION
	nvm use $NODE_VERSION
fi

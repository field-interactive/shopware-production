#!/bin/bash

CWD="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

set -e

export PROJECT_ROOT="${PROJECT_ROOT:-"$(dirname $CWD)"}"
ADMIN_ROOT="${ADMIN_ROOT:-"${PROJECT_ROOT}/vendor/shopware/administration"}"
ADMIN_ROOT=$(realpath --relative-to="$PWD" "$ADMIN_ROOT")

# build admin
[[ ${CI} ]] || "${CWD}/console" bundle:dump
npm clean-install --prefix ${ADMIN_ROOT}/Resources/app/administration

if [[ `uname -s` == CYGWIN* ]]; then
    export PROJECT_ROOT=$(/usr/bin/cygpath -w $PROJECT_ROOT)
    (cd ${ADMIN_ROOT}/Resources/app/administration && node_modules/.bin/webpack --config webpack.config.js)
else
    npm run --prefix ${ADMIN_ROOT}/Resources/app/administration/ build
fi

[[ ${CI} ]] || "${CWD}/console" asset:install

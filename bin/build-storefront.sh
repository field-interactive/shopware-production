#!/usr/bin/env bash

CWD="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

export PROJECT_ROOT="${PROJECT_ROOT:-"$(dirname "$CWD")"}"
STOREFRONT_ROOT="${STOREFRONT_ROOT:-"${PROJECT_ROOT}/vendor/shopware/storefront"}"
STOREFRONT_ROOT=$(realpath --relative-to="$PWD" "$STOREFRONT_ROOT")

# build storefront
[[ ${CI} ]] || "${CWD}/console" bundle:dump
npm --prefix ${STOREFRONT_ROOT}/Resources/app/storefront clean-install
node ${STOREFRONT_ROOT}/Resources/app/storefront/copy-to-vendor.js

if [[ `uname -s` == CYGWIN* ]]; then
    export PROJECT_ROOT=$(/usr/bin/cygpath -w $PROJECT_ROOT)
    (cd ${STOREFRONT_ROOT}/Resources/app/storefront && NODE_ENV=development node_modules/.bin/webpack --config webpack.config.js)
else
    npm --prefix "${STOREFRONT_ROOT}"/Resources/app/storefront run production
fi

[[ ${CI} ]] || "${CWD}/console" asset:install
[[ ${CI} ]] || "${CWD}/console" theme:compile

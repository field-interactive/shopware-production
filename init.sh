#!/usr/bin/env bash
#set -o xtrace
trap 'echo -e "\e[0;32m" && echo -ne $(date "+%Y-%m-%d %H:%M:%S") && echo " >> Executing: $BASH_COMMAND" && echo -e "\e[0m"' DEBUG
mysql -h127.0.0.1 -uroot -e "CREATE DATABASE application;"
composer install --no-interaction --optimize-autoloader

# Avoid: Environment variable not found: "APP_URL"
# see https://issues.shopware.com/issues/NEXT-12476

# setup the environment
APP_URL=http://127.0.0.1 bin/console assets:install
APP_URL=http://127.0.0.1 bin/console system:setup
trap - DEBUG

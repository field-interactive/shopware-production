#!/usr/bin/env bash
#DESCRIPTION: Everything from "init" + demo data generation + administration build/deploy

composer install --no-interaction --optimize-autoloader

# setup the environment
bin/console assets:install
bin/console system:setup

# create database with a basic setup (admin user and storefront sales channel)
bin/console system:install --create-database --basic-setup --force

#bin/console system:install --create-database --force
#bin/console system:generate-jwt-secret
#php fix-install.php
#bin/console user:create "admin" --admin --password="shopware" -n
#bin/console sales-channel:create:storefront --name=Storefront --url="http://localhost"
#bin/console theme:change --all Storefront

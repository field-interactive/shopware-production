#!/usr/bin/env bash
#DESCRIPTION: Everything from "init" + demo data generation + administration build/deploy

composer install --no-interaction --optimize-autoloader

# setup the environment
bin/console assets:install
bin/console system:setup

# create database with a basic setup (admin user and storefront sales channel)
bin/console system:install --create-database --basic-setup --force

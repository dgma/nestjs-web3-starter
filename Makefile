SHELL := /bin/bash

-include .env

.PHONY: init build clear lint typecheck test pre-commit pre-push migrate up up-all list funding fuel report profiles recover decrypt encrypt

all: init clean typecheck test

init:; npm i

typecheck :; npx tsc --noEmit --project tsconfig.json

clean :; rm -rf dist

lint :; npx eslint \{src,apps,libs,test\}/**/*.ts --fix

test :; npx jest --passWithNoTests

test.watch :; npx jest --passWithNoTests --watch

test.cov :; npx jest --passWithNoTests --coverage

test.debug :; node --inspect-brk -r tsconfig-paths/register -r ts-node/register node_modules/.bin/jest --runInBand

test.e2e: npx jest --config ./test/jest-e2e.json

pre-commit: typecheck lint-stg

pre-push : lint typecheck test

build:; npx nest build

lint-stg :; npx lint-staged

start:; npx nest start

start.dev:; npx nest start --watch

start.debug:; npx nest start --debug --watch

start.prod:; node dist/main

-include ${FCT_PLUGIN_PATH}/makefile-external
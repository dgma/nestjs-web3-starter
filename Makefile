SHELL := /bin/bash

-include .env

.PHONY: init typecheck clean lint test test.watch test.cov test.debug test.e2e pre-commit pre-push build lint-stg start start.dev start.debug start.debug.open start.prod up.dev build.prod up.prod clear.prod encrypt.prod

all: init clean typecheck

init:; npm i

typecheck :; npx tsc --noEmit --project tsconfig.json

clean :; rm -rf dist

lint :; npx eslint \{src,apps,libs,test\}/**/*.ts --fix

test :; npx jest --passWithNoTests

test.watch :; npx jest --passWithNoTests --watch

test.cov :; npx jest --passWithNoTests --coverage

test.debug :; node --inspect-brk -r tsconfig-paths/register -r ts-node/register node_modules/.bin/jest --runInBand

test.e2e:; npx jest --config ./jest-e2e.config.ts

pre-commit: typecheck lint-stg

pre-push : lint typecheck test

build:; npx nest build

lint-stg :; npx lint-staged

start:; npx nest start

start.dev:; npx nest start --watch

start.debug:; npx nest start --debug --watch

start.debug.open:; npx nest start --debug 0.0.0.0 --watch

start.prod:; node dist/main

# docker aliases

up.dev:
	@docker compose up -d && docker compose logs -f

build.prod:
	@docker compose -f docker-compose.prod.yml build

up.prod:
	@docker compose -f docker-compose.prod.yml up -d && docker compose -f docker-compose.prod.yml logs -f

clear.prod: 
	@docker compose -f docker-compose.prod.yml down

# encryption setup
encrypt.prod:
	@npx dotenvx encrypt -f conf/.production.secrets.env

-include ${FCT_PLUGIN_PATH}/makefile-external
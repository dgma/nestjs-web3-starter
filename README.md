# nestjs-web3-starter

Development starter kit for web3 node.js apps with nestjs & viem

## Technologies

- [Nestjs](https://nestjs.com/) with [Typescript](https://www.typescriptlang.org/) and [SWC](https://swc.rs/)
- [Jest](https://jestjs.io/) for unit and e2e testing
- [Docker](https://www.docker.com/) & [Docker-compose](https://docs.docker.com/compose/) for dev & prod.
- linters, code formatter, pre-commit and pre-push hooks
- Custom github action and quality gate workflow for fast CI strategy implementation
- Flexible env configuration with encryption, thanks to [dotenvx](https://dotenvx.com/)

## Requirements

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you've done it right if you can run `git --version`
- [Node.js](https://nodejs.org/en) v20+
- [Make](https://www.gnu.org/software/make/manual/make.html)
- Optional. [Docker](https://www.docker.com/)
  - You'll need to run docker if you want to use run production container builds locally

## Installation

```sh
make
```

## Configuration

### Local development

1. Create and modify .env and .local.secrets.env files:

   ```sh
   cp conf/.example.env conf/.env \
   && cp conf/.example.secrets.env conf/.local.secrets.env
   ```

### Production

1. Create and modify .env and .production.secrets.env files:

   ```sh
   rm conf/.production.secrets.env \
   && cp conf/.example.env conf/.env \
   && cp conf/.example.secrets.env conf/.production.secrets.env
   ```

   **note**: you can commit .production.secrets.env after encryption

2. Encrypt prod secrets:

   ```sh
   make encrypt.prod
   ```

3. Keep generated .env.keys safe and do not commit it into repo

## Running

Without docker:

```sh
# development mode
make start.dev
```

```sh
# development mode, watch & debug
make start.debug
```

```sh
# production mode
make start.prod
```

With docker

```sh
# development mode, watch mode & debug
docker compose up
```

```sh
# production mode
make up.prod
```

## Contributing

Contributions are always welcome! Open a PR or an issue!

## Notes

And you probably already have `make` installed... but if not [try looking here.](https://askubuntu.com/questions/161104/how-do-i-install-make)

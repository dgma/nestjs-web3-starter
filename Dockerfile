FROM node:20-alpine as base
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk update && apk add --no-cache libc6-compat
WORKDIR /app
EXPOSE 3000

# Rebuild the source code only when needed
FROM base as deps
RUN apk add --no-cache make && apk add --no-cache bash
COPY . .
RUN npm ci

FROM deps as prod
ENV NODE_ENV=production
RUN make build
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 prod-nodejs
USER prod-nodejs
CMD ["make", "start.prod"]

FROM deps as dev
EXPOSE 9229
ENV NODE_ENV=development
RUN make build
CMD ["make", "start.debug.open"]
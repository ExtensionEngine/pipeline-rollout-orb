FROM node:24.2.0-bookworm-slim@sha256:b30c143a092c7dced8e17ad67a8783c03234d4844ee84c39090c9780491aaf89 as base

RUN apt-get update && apt-get install -y --no-install-recommends dumb-init
ENTRYPOINT ["dumb-init", "--"]

###

FROM node:24.2.0-bookworm@sha256:d1db2ecd11f417ab2ff4fef891b4d27194c367d101f9b9cd546a26e424e93d31 as install

WORKDIR /usr/src/app

ENV PNPM_HOME="/pnpm"
ENV PNPM_VERSION=9.11.0
ENV PATH="$PNPM_HOME:$PATH"
RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -

COPY package.json pnpm-lock.yaml ./

###

FROM install as dependencies

ENV NODE_ENV production
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

###

FROM install as build

COPY ./src tsconfig.json tsconfig.build.json nest-cli.json ./
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

###

FROM base AS configure

WORKDIR /usr/src/app
COPY --chown=node:node --from=dependencies /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

###

FROM configure AS run

ENV NODE_ENV production
USER node
CMD ["node", "dist/main.js"]

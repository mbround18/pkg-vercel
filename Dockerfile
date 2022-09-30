ARG TARGET_NODE="18.5.0"
FROM node:${TARGET_NODE}-alpine as builder

ARG PKG_VERSION="3.4"
ARG TARGET_NODE="18.5.0"

ENV PKG_CACHE_PATH=/app/.pkg-config

WORKDIR /app

RUN corepack enable yarn
ADD "https://github.com/vercel/pkg-fetch/releases/download/v${PKG_VERSION}/node-v${TARGET_NODE}-alpine-x64" "${PKG_CACHE_PATH}/v${PKG_VERSION}/fetched-v${TARGET_NODE}-alpine-x64"

COPY ./package.json ./.yarnrc.yml ./yarn.lock ./
COPY ./.yarn ./.yarn

RUN yarn install                                                 

COPY . .

RUN yarn build                                                    \
  && yarn pkg -t "node${TARGET_NODE%%.*}-alpine-x64" package.json  \
  && cd /app/dist/ && ls -l

FROM alpine as runtime

EXPOSE 3000

COPY --from=builder /app/dist/pkg-demo /bin/pkg-demo

ENTRYPOINT ["/bin/pkg-demo" ]

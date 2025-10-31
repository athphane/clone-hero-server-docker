FROM debian:bullseye-slim AS build-env

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /clonehero

RUN apt-get update \
    && apt-get install --no-install-recommends -y ca-certificates wget unzip curl jq libicu67 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir config

COPY ./startup.sh .

COPY ./config/server-settings.ini ./config/

RUN wget -qO chserver.zip https://github.com/clonehero-game/releases/releases/latest/download/CloneHero-standalone_server.zip \
    && unzip chserver.zip \
    && rm ./chserver.zip \
    && mv ChStandaloneServer-*/linux-x64/Server ./clone-hero-server \
    && rm -rf ChStandaloneServer-* \
    && chmod +x ./clone-hero-server \
    && chown -R 1000 ./config

FROM debian:bullseye-slim

RUN apt-get update \
    && apt-get install --no-install-recommends -y ca-certificates libicu67 libgssapi-krb5-2 \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/src/clonehero/clone-hero-server /usr/bin/cloneheroserver \
    && useradd -m clonehero

WORKDIR /usr/src/clonehero
COPY --from=build-env /clonehero .
USER clonehero

WORKDIR /usr/src/clonehero/config

EXPOSE 14242/udp
ENTRYPOINT ["../startup.sh"]
FROM debian:buster-slim AS build-env

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /clonehero

RUN apt-get update \
 && apt-get install --no-install-recommends -y ca-certificates wget unzip curl jq libicu63 \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir config

COPY ./startup.sh .

COPY ./config/server-settings.ini ./config/

RUN wget -qO chserver.zip https://github.com/clonehero-game/releases/releases/latest/download/CloneHero-standalone_server.zip \
 && unzip chserver.zip \
 && rm ./chserver.zip \
 && mv ./ChStandaloneServer-* ./chserver \
 && mv ./chserver/linux-x64/* . \
 && rm -rf ./chserver \
 && mv ./Server ./clone-hero-server \
 && chmod +x ./clone-hero-server \
 && chown -R 1000 ./config

FROM debian:buster-slim

RUN apt-get update \
 && apt-get install --no-install-recommends -y ca-certificates libicu63 libgssapi-krb5-2 \
 && rm -rf /var/lib/apt/lists/* \
 && ln -sf /usr/src/clonehero/clone-hero-server /usr/bin/cloneheroserver \
 && useradd -m clonehero

WORKDIR /usr/src/clonehero
COPY --from=build-env /clonehero .
USER clonehero

WORKDIR /usr/src/clonehero/config

EXPOSE 14242/udp
ENTRYPOINT ["../startup.sh"]

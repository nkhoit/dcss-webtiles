# syntax=docker/dockerfile:1
ARG UBUNTU_VERSION=24.04

# =============================================================================
# Builder
# =============================================================================
FROM ubuntu:${UBUNTU_VERSION} AS builder

ARG CRAWL_VERSION=0.34.0
ARG CRAWL_REPO=https://github.com/crawl/crawl.git
ARG MAKE_JOBS=4

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf bison build-essential flex git \
    libncursesw5-dev libsqlite3-dev libz-dev pkg-config \
    binutils-gold libsdl2-image-dev libsdl2-mixer-dev libsdl2-dev \
    libfreetype-dev libpng-dev fonts-dejavu-core advancecomp pngcrush \
    ca-certificates python3-yaml \
  && rm -rf /var/lib/apt/lists/*

RUN git clone --branch ${CRAWL_VERSION} --depth 1 ${CRAWL_REPO} /src \
  && cd /src && git submodule update --init

RUN cd /src/crawl-ref/source \
  && make install -j${MAKE_JOBS} \
       DESTDIR=/build \
       USE_DGAMELAUNCH=y \
       WEBTILES=y

RUN cp -r /src/crawl-ref/source/webserver /build/ \
  && cp -r /src/crawl-ref/source/util /build/

# =============================================================================
# Runtime
# =============================================================================
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive \
    DATA_DIR=/data

RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 python3-minimal python3-pip python3-yaml \
    ncurses-term locales-all sqlite3 libpcre3 locales \
    liblua5.1-0 lsof \
  && pip3 install --break-system-packages tornado \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/ /app/
COPY config.py  /app/webserver/config.py
COPY games.yaml /app/webserver/games.d/base.yaml
COPY init.txt   /app/settings/init.txt
COPY webtiles-init-player.sh /app/util/webtiles-init-player.sh
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh /app/util/webtiles-init-player.sh

EXPOSE 8080
WORKDIR /app
VOLUME /data

ENTRYPOINT ["./entrypoint.sh"]

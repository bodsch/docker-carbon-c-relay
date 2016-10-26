
FROM bodsch/docker-alpine-base:1610-02

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1.6.1"

EXPOSE 2003

ENV VERSION 2.2

# ---------------------------------------------------------------------------------------

RUN \
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add \
    build-base \
    git \
    curl && \
  curl \
  --silent \
  --location \
  --retry 3 \
  --cacert /etc/ssl/certs/ca-certificates.crt \
  https://github.com/grobian/carbon-c-relay/archive/v${VERSION}.tar.gz \
    | gunzip \
    | tar x -C /opt/ && \
  cd /opt/carbon-c-relay-${VERSION} && \
  make && \
  cp relay /usr/bin/carbon-c-relay && \
  apk del --purge \
    build-base \
    git \
    ca-certificates \
    curl && \
  rm -rf \
    /opt/* \
    /tmp/* \
    /var/cache/apk/*

COPY rootfs/ /

CMD /opt/startup.sh

# ---------------------------------------------------------------------------------------


FROM bodsch/docker-alpine-base:1609-01

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1.5.2"

ENV VERSION 2.2

# ---------------------------------------------------------------------------------------

RUN \
  apk --quiet --no-cache update && \
  apk --quiet --no-cache upgrade && \
  apk --quiet --no-cache add \
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
  cp relay /usr/bin/ && \
  mkdir /etc/carbon-relay && \
  mkdir /var/log/carbon-relay && \
  cp -v issues/*.conf /etc/carbon-relay/ && \
  apk del --purge \
    build-base \
    git \
    curl && \
  rm -rf \
    /tmp/* \
    /var/cache/apk/*

ADD rootfs/ /

CMD [ "/opt/startup.sh" ]

# CMD [ '/bin/sh' ]

# EOF

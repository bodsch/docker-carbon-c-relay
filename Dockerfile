
FROM alpine:3.8 as builder

ARG BUILD_DATE
ARG BUILD_VERSION
ARG BUILD_TYPE
ARG VERSION

# ---------------------------------------------------------------------------------------

RUN \
  apk update  --quiet --no-cache && \
  apk upgrade --quiet --no-cache && \
  apk add     --quiet --no-cache \
    automake g++ git make musl-dev zlib-dev lz4-dev openssl-dev

RUN \
  echo "export BUILD_DATE=${BUILD_DATE}"            > /etc/profile.d/carbon-c-relay.sh && \
  echo "export BUILD_TYPE=${BUILD_TYPE}"           >> /etc/profile.d/carbon-c-relay.sh

RUN \
  cd /tmp && \
  git clone https://github.com/grobian/carbon-c-relay.git && \
  cd carbon-c-relay && \
  if [ "${BUILD_TYPE}" == "stable" ] ; then \
    echo "switch to stable Tag v${VERSION}" && \
    git checkout tags/v${VERSION} 2> /dev/null ; \
  fi && \
  version=$(git describe --tags --always | sed 's/^v//') && \
  echo "build version: ${version}"

RUN \
  cd /tmp/carbon-c-relay && \
  ./configure && \
  make && make install

CMD [ "/bin/sh" ]

# ---------------------------------------------------------------------------------------

FROM alpine:3.8

ENV \
  TZ='Europe/Berlin'

RUN \
  apk update --no-cache --quiet && \
  apk add    --no-cache --quiet --virtual .build-deps \
    shadow tzdata && \
  apk add    --no-cache --quiet \
    lz4-libs zlib openssl && \
  cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone && \
  /usr/sbin/useradd --system -U -s /bin/false -c "User for Graphite daemon" relay && \
  apk del --quiet --purge .build-deps && \
  rm -rf \
    /tmp/* \
    /var/cache/apk/*

COPY --from=builder /etc/profile.d/carbon-c-relay.sh /etc/profile.d/carbon-c-relay.sh
COPY --from=builder /usr/local/bin/relay /usr/bin/
COPY rootfs/ /

EXPOSE 2003

LABEL \
  version=${BUILD_VERSION} \
  maintainer="Bodo Schulz <bodo@boone-schulz.de>" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.name="carbon-relay-ng Docker Image" \
  org.label-schema.description="Inofficial carbon-relay-ng Docker Image" \
  org.label-schema.url="https://github.com/graphite-ng/carbon-relay-ng" \
  org.label-schema.vcs-url="https://github.com/bodsch/docker-docker-carbon-relay-ng" \
  org.label-schema.vendor="Bodo Schulz" \
  org.label-schema.version=${VERSION} \
  org.label-schema.schema-version="1.0" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="The Unlicense"

CMD [ "/init/run.sh" ]

# ---------------------------------------------------------------------------------------

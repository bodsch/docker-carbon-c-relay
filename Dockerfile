FROM bodsch/docker-alpine-base:latest

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1.5.0"

# 3000: grafana (plain)
# EXPOSE 3000

ENV VERSION 2.1

# ---------------------------------------------------------------------------------------

RUN \
  apk --quiet --no-cache update && \
  apk --quiet --no-cache add \
    build-base \
    git \
    netcat-openbsd \
    curl \
    pwgen \
    jq \
    yajl-tools && \
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
  cp relay /usr/bin/


#ADD rootfs/ /

#VOLUME [ "/usr/share/grafana/data" "/usr/share/grafana/public/dashboards" "/opt/grafana/dashboards" ]

#WORKDIR /usr/share/grafana

# CMD [ "/opt/startup.sh" ]

CMD [ '/bin/sh' ]

# EOF

#!/bin/sh

#set -e
#set -x

. /etc/profile

GRAPHITE_HOST=${GRAPHITE_HOST:-graphite}
GRAPHITE_PORT=${GRAPHITE_PORT:-2003}

config_file="/etc/carbon-c-relay.conf"

create_config() {

  sed -i \
    -e "s/%GRAPHITE_HOST%/${GRAPHITE_HOST}/" \
    -e "s/%GRAPHITE_PORT%/${GRAPHITE_PORT}/" \
    ${config_file}
}

run() {

  create_config

  #  -v  print version and exit
  #  -f  read <config> for clusters and routes
  #  -p  listen on <port> for connections, defaults to 2003
  #  -l  write output to <file>, defaults to stdout/stderr
  #  -w  use <workers> worker threads, defaults to 8
  #  -b  server send batch size, defaults to 2500
  #  -q  server queue size, defaults to 25000
  #  -L  server max stalls, defaults to 4
  #  -S  statistics sending interval in seconds, defaults to 60
  #  -B  connection listen backlog, defaults to 32
  #  -U  socket receive buffer size, max/min/default values depend on OS
  #  -T  IO timeout in milliseconds for server connections, defaults to 600
  #  -m  send statistics like carbon-cache.py, e.g. not cumulative
  #  -c  characters to allow next to [A-Za-z0-9], defaults to -_:#
  #  -d  debug mode: currently writes statistics to log, prints hash
  #      ring contents and matching position in test mode (-t)
  #  -s  submission mode: don't add any metrics to the stream like
  #      statistics, report drop counts and queue pressure to log
  #  -t  config test mode: prints rule matches from input on stdin
  #  -H  hostname: override hostname (used in statistics)
  #  -D  daemonise: run in a background
  #  -P  pidfile: write a pid to a specified pidfile
  #  -O  minimum number of rules before optimising the ruleset, default: 50

  /usr/bin/relay \
    -f ${config_file} \
    -t  < /dev/null > /dev/null

  /usr/bin/relay \
    -f ${config_file} \
    -m \
    -l /dev/stdout
}

run

# EOF

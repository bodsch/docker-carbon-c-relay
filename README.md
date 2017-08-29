docker-carbon-c-relay
=====================

A Docker container for the Enhanced C implementation of Carbon relay, aggregator and rewriter (https://github.com/grobian/carbon-c-relay)

# Status

[![Docker Pulls](https://img.shields.io/docker/pulls/bodsch/docker-carbon-c-relay.svg?branch)][hub]
[![Image Size](https://images.microbadger.com/badges/image/bodsch/docker-carbon-c-relay.svg?branch)][microbadger]
[![Build Status](https://travis-ci.org/bodsch/docker-carbon-c-relay.svg?branch)][travis]

[hub]: https://hub.docker.com/r/bodsch/docker-carbon-c-relay/
[microbadger]: https://microbadger.com/images/bodsch/docker-carbon-c-relay
[travis]: https://travis-ci.org/bodsch/docker-carbon-c-relay


# Build

Your can use the included Makefile.

To build the Container:
    make build

Starts the Container:
    make run

Starts the Container with Login Shell:
    make shell

Entering the Container:
    make exec

Stop (but **not kill**):
    make stop

History
    make history


# Docker Hub

You can find the Container also at  [DockerHub](https://hub.docker.com/r/bodsch/docker-carbon-c-relay)

## get

    docker pull bodsch/docker-carbon-c-relay


# supported Environment Vars

  - GRAPHITE_HOST  (default: ```graphite```)
  - GRAPHITE_PORT  (default: ```2003```)


# Ports

  - 2003

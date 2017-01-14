docker-carbon-c-relay
=====================

A Docker container for the Enhanced C implementation of Carbon relay, aggregator and rewriter (https://github.com/grobian/carbon-c-relay)

# Status

[![Build Status](https://travis-ci.org/bodsch/docker-carbon-c-relay.svg?branch=1701-02)](https://travis-ci.org/bodsch/docker-carbon-c-relay)


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

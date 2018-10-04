# Serverless docker image

[![Build Status](https://img.shields.io/travis/graze/serverless/master.svg)](https://travis-ci.org/graze/serverless)
[![Docker Pulls](https://img.shields.io/docker/pulls/graze/php-alpine.svg)](https://hub.docker.com/r/graze/php-alpine/)
[![Image Size](https://images.microbadger.com/badges/image/graze/php-alpine.svg)](https://microbadger.com/images/graze/php-alpine)

Public image for serverless

## Dev

    ~ $ make build

## Pulling

    ~ $ docker pull graze/serverless

## Usage

    ~ $ docker run --rm graze/serverless -v $(pwd):/srv serverless deploy

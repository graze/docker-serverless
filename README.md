# Serverless docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/graze/serverless.svg)](https://hub.docker.com/r/graze/php-alpine/)
[![Image Size](https://images.microbadger.com/badges/image/graze/serverless.svg)](https://microbadger.com/images/graze/php-alpine)

Public image for serverless

## Dev

    ~ $ make build

## Pulling

    ~ $ docker pull graze/serverless

## Usage

    ~ $ docker run --rm graze/serverless -v $(pwd):/srv serverless deploy

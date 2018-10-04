#!/usr/bin/env bats

readonly container="graze/serverless:${VERSION:?1.32.0}"

@test "alpine version is the correct" {
  run docker run --rm --entrypoint=/bin/sh ${container} -c 'cat /etc/alpine-version'
  echo 'status:' $status
  echo 'output:' $output
  echo 'version:' $version
  [ "$status" -eq 0 ]
  [[ "$output" == "3.8."* ]]
}

@test "serverless version is correct" {
  run docker run --rm ${container} --version
  echo 'status:' $status
  echo 'output:' $output
  echo 'version:' $version
  [ "$status" -eq 0 ]
  [[ "$output" == "1.32.0" ]]
}

@test "the image has a MIT license" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.license'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" = "MIT" ]
}

@test "the image has a maintainer" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.maintainer'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" = "developers@graze.com" ]
}

@test "the image uses label-schema.org" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.\"org.label-schema.schema-version\"'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" = "1.0" ]
}

@test "the image has a vcs-url label" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.\"org.label-schema.vcs-url\"'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" = "https://github.com/graze/docker-serverless" ]
}

@test "the image has a vcs-ref label set to the current head commit in github" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.\"org.label-schema.vcs-ref\"'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" = `git rev-parse --short HEAD` ]
}

@test "the image has a build-date label" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.\"org.label-schema.build-date\"'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" != "null" ]
}

@test "the image has a vendor label" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.\"org.label-schema.vendor\"'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" = "graze" ]
}

@test "the image has a name label" {
  run bash -c "docker inspect ${container} | jq -r '.[].Config.Labels.\"org.label-schema.name\"'"
  echo 'status:' $status
  echo 'output:' $output
  [ "$status" -eq 0 ]
  [ "$output" = "serverless" ]
}

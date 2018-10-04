SHELL = /bin/bash

docker_bats := docker run --rm \
		-v $$(pwd):/app -v /var/run/docker.sock:/var/run/docker.sock \
		graze/bats

.PHONY: build build-quick
.PHONY: tag
.PHONY: test

.DEFAULT: build
build: build-latest
build-quick:
	make build cache="" pull=""

build-%: cache ?= --no-cache
build-%: pull ?= --pull
build-%: ## build a generic image
	docker build ${cache} ${pull} --build-arg VERSION=$* -t graze/serverless:$* .

clean-%: ## Clean up the images
	docker rmi $$(docker images -q graze/serverless:$**) || echo "no images"

test: test-latest
test-%: ## Test a version
	docker run --rm \
		-e VERSION=$* \
		-v $$(pwd):/app -v /var/run/docker.sock:/var/run/docker.sock \
		graze/bats tests.bats

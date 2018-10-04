build_args := --build-arg BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
              --build-arg VCS_REF=$(shell git rev-parse --short HEAD)

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
	docker build ${build_args} ${cache} ${pull} --build-arg VERSION=$* -t graze/serverless:$* .

clean-%: ## Clean up the images
	docker rmi $$(docker images -q graze/serverless:$**) || echo "no images"

test: test-latest
test-%: ## Test a version
	docker run --rm \
		-e VERSION=$* \
		-v $$(pwd):/app -v /var/run/docker.sock:/var/run/docker.sock \
		graze/bats tests.bats

release-$*: ## Release a new version
	${MAKE} build-$* test-$* && git tag $* && git push $*

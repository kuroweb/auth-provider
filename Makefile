# ArgoCDによるGitOps用のMakefile

#
# config
#

registry := docker-registry.kuroweb.net
project := auth-provider
tag_suffix := $(shell git rev-parse --short HEAD)
environment ?= production

#
# util
#

# すべて実行する
all: build-all push-all

# Dockerイメージをビルドする
build-all: build-backend

# Dockerイメージをプッシュする
push-all: push-backend

#
# backend
#

backend_tag := $(registry)/$(project)-backend-$(environment):$(tag_suffix)
backend_dockerfile := containers/backend/Dockerfile.$(environment)

build-backend:
	docker build \
	-t $(backend_tag) \
	-f $(backend_dockerfile) volumes/backend

push-backend:
	docker push $(backend_tag)

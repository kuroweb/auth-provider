# ArgoCDによるGitOps用のMakefile

#
# config
#

registry := docker-registry.kuroweb.net
project := auth-provider
tag_suffix := $(shell git rev-parse --short HEAD)

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

backend_tag := $(registry)/$(project)-backend:$(tag_suffix)

build-backend:
	docker build \
	-t $(backend_tag) \
	-f containers/backend/Dockerfile.prod volumes/backend

push-backend:
	docker push $(backend_tag)

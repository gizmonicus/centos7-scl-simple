# from http://www.itnotes.de/docker/development/tools/2014/08/31/speed-up-your-docker-workflow-with-a-makefile/
include env_make
NS = gizmonicus
VERSION ?= latest

REPO = centos7-scl-simple
NAME = centos7-scl-simple
INSTANCE = default

CONTAINER_RUNNING=$(shell docker ps | grep -qw $(NAME)-$(INSTANCE) && echo 1 || echo 0)
CONTAINER_EXISTS=$(shell docker ps -a | grep -qw $(NAME)-$(INSTANCE) && echo 1 || echo 0)

# if container is not running, start it first
ifeq ($(CONTAINER_RUNNING), 0)
shell: run
endif

# if container is running stop before removing
ifeq ($(CONTAINER_RUNNING), 1)
rm: stop
endif

.PHONY: build nocache shell run start stop rm ps

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .

nocache:
	docker build --no-cache -t $(NS)/$(REPO):$(VERSION) .

shell:
	docker exec -it $(NAME)-$(INSTANCE) /bin/bash

run:
	@if [ $(CONTAINER_EXISTS) -eq 0 ]; then \
		echo docker run -d --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION); \
		docker run -d --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION); \
	else \
		echo docker start $(NAME)-$(INSTANCE) ; \
		docker start $(NAME)-$(INSTANCE) ; \
	fi

start:
	docker start $(NAME)-$(INSTANCE)

stop:
	docker stop $(NAME)-$(INSTANCE)

rm:
	docker rm $(NAME)-$(INSTANCE)

ps:
	docker ps

pull:
	docker pull $(NS)/$(REPO):$(VERSION)

default: build

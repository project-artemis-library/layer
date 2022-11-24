SHELL = /usr/bin/env bash -xeuo pipefail

stack_name:=project-artemis-library-layer

build: build-collection

export-collection:
	cd ./collection/; \
	poetry export > requirements.txt

build-collection: export-collection
	docker image build -f ./Dockerfile -t collection:latest ./collection/
	docker container run --name collection collection:latest
	mkdir -p ./layers/collection
	docker container cp collection:/tmp/layer/ ./layers/collection/
	docker container rm collection
	docker image rm collection:latest

.PHONY: \
	build-collection \
	export-collection \
	build 


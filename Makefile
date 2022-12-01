SHELL = /usr/bin/env bash -xeuo pipefail

stack_name:=project-artemis-library-layer

clean:
	rm -rf layers/
	find . -type f -name requirements.txt | xargs rm

build: clean build-collection

export-collection:
	cd ./collection/; \
	poetry export > requirements.txt

build-collection: export-collection
	./build.sh collection

.PHONY: \
	build-collection \
	export-collection \
	clean \
	build


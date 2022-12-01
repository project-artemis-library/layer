SHELL = /usr/bin/env bash -xeuo pipefail

stack_name:=project-artemis-library-layer

clean:
	rm -f template.yml
	rm -rf layers/
	find . -type f -name requirements.txt | xargs rm

build: build-collection

export-collection:
	cd ./collection/; \
	poetry export > requirements.txt

build-collection: export-collection
	./build.sh collection

sam-validate:
	sam validate -t sam.yml

package:
	sam package \
		--s3-bucket ${SAM_ARTIFACT_BUCKET} \
		--s3-prefix layer \
		--template-file sam.yml \
		--output-template-file template.yml

deploy:
	sam deploy \
		--stack-name $(stack_name) \
		--template-file template.yml \
		--no-fail-on-empty-changeset

describe:
	aws cloudformation describe-stacks \
		--stack-name $(stack_name) \
		--query Stacks[0].Outputs

.PHONY: \
	build-collection \
	export-collection \
	sam-validate \
	package \
	deploy \
	describe \
	clean \
	build


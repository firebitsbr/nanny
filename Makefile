SHELL := /bin/bash
export TESTS
header = "  \e[1;34m%-30s\e[m \n"
row = "\e[1mmake %-32s\e[m %-50s \n"

all:
	@printf $(header) "Build"
	@printf $(row) "build" "Build production binary."
	@printf $(row) "package" "Build and create .tar.gz."
	@printf $(row) "clean" "Clean from build artefacts."
	@printf $(header) "Dev"
	@printf $(row) "run" "Run Nanny in dev mode, all logging and race detector ON."
	@printf $(row) "test" "Run tests."
	@printf $(row) "vet" "Run go vet."
	@printf $(row) "lint" "Run gometalinter (you have to install it)."

build:
	go build

package: clean build
	scripts/package.sh

run: 
	LOGXI=* go run -race main.go

test: 
	go test -race -cover -v ./...

vet:
	go vet ./...

lint:
	gometalinter.v2 --disable=vetshadow --vendor ./...

clean:
	rm nanny || true
	rm *.tar.gz || true
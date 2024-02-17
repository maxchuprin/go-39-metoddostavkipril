PUBLIC_REGISTRY_HOST=docker.io
PUBLIC_REGISTRY_OWNER=mchuprin135246
PUBLIC_REGISTRY_APP_NAME=module-39

CI_COMMIT_REF_NAME=latest

all: deps build test

deps:
	@go mod download
	@echo "Dependencies installed successfully"

build:
	$(info Building...)
	@go build ./
	$(info Build successful)

test:
	$(info Running tests...)
	@go test -v ./...
	$(info Tests completed)

lint:
	$(info Linting...)
	@golangci-lint run ./...
	$(info Linting completed)

image:
	$(info Building Docker image...)
	@docker build -t ${PUBLIC_REGISTRY_HOST}/${PUBLIC_REGISTRY_OWNER}/${PUBLIC_REGISTRY_APP_NAME}:${CI_COMMIT_REF_NAME} ./
	$(info Docker image built successfully)
	$(info Pushing Docker image...)
	@docker push ${PUBLIC_REGISTRY_HOST}/${PUBLIC_REGISTRY_OWNER}/${PUBLIC_REGISTRY_APP_NAME}:${CI_COMMIT_REF_NAME}
	$(info Docker image pushed successfully)

.DEFAULT_GOAL := help

BUILD_ARTIFACTS_FOLDER := dist

.PHONY: ftp-connect ftp-deploy
ftp-connect: ## connect to OVH hosting via ftp
	ncftp ovh
ftp-deploy: ## deploy to OVH hosting via ftp
	ncftpput -R ovh . dist/*

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

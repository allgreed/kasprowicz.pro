.DEFAULT_GOAL := help

BUILD_ARTIFACTS_FOLDER := dist
FTP_DEPLOY_TARGET := ovh

.PHONY: all
all: static ftp-deploy ## build and deploy!

.PHONY: ftp-connect serve init
ftp-connect: ## connect to OVH hosting via ftp
	ncftp $(FTP_DEPLOY_TARGET)
serve: ## fire up development server (drafts included)
	xdg-open http://localhost:1313/ # this is a hax - the browser opens before hugo dev server does, but the dev server starts so fast that it works ;d
	hugo server -w --buildDrafts --buildFuture

init: ## one time setup
	direnv allow

.PHONY: ftp-deploy static
ftp-deploy: ## deploy to OVH hosting via ftp
	ncftpput -R $(FTP_DEPLOY_TARGET) . $(BUILD_ARTIFACTS_FOLDER)/*
static: ## create static artifacts (no postprocessing though)
	rm -fr $(BUILD_ARTIFACTS_FOLDER)
	hugo --destination $(BUILD_ARTIFACTS_FOLDER)

.PHONY: help
help: ## print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

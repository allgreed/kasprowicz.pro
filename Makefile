.DEFAULT_GOAL := help

BUILD_ARTIFACTS_FOLDER := dist
FTP_DEPLOY_TARGET := ovh

.PHONY: all
all: build ftp-deploy ## build and deploy!

.PHONY: ftp-connect run init
ftp-connect: ## connect to OVH hosting via ftp
	lftp $(FTP_DEPLOY_TARGET)

run: ## fire up development server (drafts included)
	sleep 3 && xdg-open http://localhost:1313/ & # this is a hax - the browser opens before hugo dev server does, but the dev server starts so fast that it works ;d
	hugo server -w --buildDrafts --buildFuture --bind 0.0.0.0

init: ## one time setup
	direnv allow

.PHONY: ftp-deploy build
ftp-deploy: vendor/CV.pdf ## deploy to OVH hosting via ftp
	lftp -e "mirror -R  --parallel=8 --verbose dist www; exit" $(FTP_DEPLOY_TARGET)
	lftp -e "mirror -R  --verbose vendor www/vendor; exit" $(FTP_DEPLOY_TARGET)

build: ## create build artifacts (no postprocessing though)
	rm -fr $(BUILD_ARTIFACTS_FOLDER)
	hugo --destination $(BUILD_ARTIFACTS_FOLDER) --minify

.PHONY: help
help: ## print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

vendor/CV.pdf:
	mkdir -p vendor
	echo Paste latest CV to vendor/CV.pdf and press enter
	read

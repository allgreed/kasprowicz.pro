.DEFAULT_GOAL := help

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
ftp-deploy: vendor/CV.pdf vendor/CV-d.pdf dist ## deploy to OVH hosting via ftp
	lftp -e "mirror -R  --parallel=8 dist www; exit" $(FTP_DEPLOY_TARGET)
	lftp -e "mirror -R  vendor www/vendor; exit" $(FTP_DEPLOY_TARGET)

build: dist ## create build artifacts (no postprocessing though)

dist: clean_dist
	hugo --destination dist --minify

.PHONY: clean_dist
clean_dist:
	rm -fr dist
	mkdir -p dist

vendor/CV.pdf: vendor
	echo Paste latest CV to vendor/CV.pdf and press enter
	read

vendor/CV-d.pdf: vendor
	echo Paste latest CV to vendor/CV-d.pdf and press enter
	read

vendor:
	mkdir -p vendor

.PHONY: help
help: ## print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

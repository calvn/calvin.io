GIT_ORIGIN=$(shell git config --get remote.origin.url)

default: build

# Essentially runs the hugo command to build the static site under public/
build: ## Build static site with hugo
	@hugo
.PHONY: build

commit: ## Commit changes on public/ directory
	@git add public/
	@git commit -m "Update the public folder with changes"
	@git push
.PHONY: commit_changes

# Pushes public/ to gh-pages branch as a git subtree
publish: build commit ## Push and publish changes
	@git subtree push --prefix=public ${GIT_ORIGIN} gh-pages
.PHONY: publish

help: ## Show this help
	@echo "Publishing made easy - run \`make publish\`"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.PHONY: help

# Makefile for Rust project

# Variables
CARGO := cargo
TARGET_DIR := target
RELEASE_DIR := $(TARGET_DIR)/release
DEBUG_DIR := $(TARGET_DIR)/debug
GIT := git
DOCKER_COMPOSE := docker-compose

# Automatically detect docker-compose file (override if present)
COMPOSE_FILE := $(if $(wildcard docker-compose.override.yml),docker-compose.override.yml,docker-compose.yml)

# Default target
.PHONY: all
all: build

# Rust-related targets
.PHONY: build release run test lint format clean doc outdated update info
build:
	$(CARGO) build

release:
	$(CARGO) build --release

run:
	$(CARGO) run

test:
	$(CARGO) test

lint:
	$(CARGO) clippy

format:
	$(CARGO) fmt

clean:
	$(CARGO) clean

doc:
	$(CARGO) doc

outdated:
	$(CARGO) outdated

update:
	$(CARGO) update

info:
	$(CARGO) info

# Basic Git commands
.PHONY: git-status git-add git-commit git-push git-pull git-log

git-status:
	$(GIT) status

git-add:
	$(GIT) add .

git-commit:
	@read -p "Enter commit message: " message; \
	$(GIT) commit -m "$$message"

git-push:
	$(GIT) push

git-pull:
	$(GIT) pull

git-log:
	$(GIT) log --oneline -n 10

# Advanced Git commands
.PHONY: git-amend git-stash git-unstash git-undo git-branch-cleanup git-conflict-files git-graph git-blame-history git-search-commits

git-amend:
	$(GIT) commit --amend

git-stash:
	$(GIT) stash push -m "Stashed via Makefile"

git-unstash:
	$(GIT) stash pop

git-undo:
	$(GIT) reset HEAD~1

git-branch-cleanup:
	$(GIT) fetch -p && for branch in `$(GIT) branch -vv | grep ': gone]' | awk '{print $$1}'`; do $(GIT) branch -D $$branch; done

git-conflict-files:
	$(GIT) diff --name-only --diff-filter=U

git-graph:
	$(GIT) log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

git-blame-history:
	@read -p "Enter file path: " file; \
	$(GIT) log -p -M --follow --stat -- $$file

git-search-commits:
	@read -p "Enter search term: " term; \
	$(GIT) log -S"$$term" --pretty=format:'%h - %an, %ar : %s'

# Docker Compose commands with automatic file detection
.PHONY: docker-up docker-down docker-build docker-logs docker-exec docker-stop

docker-up:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

docker-down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

docker-build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

docker-logs:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

docker-exec:
	@read -p "Enter service name: " service; \
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) exec $$service /bin/sh

docker-stop:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop

.PHONY: help
help:
	@echo ""
	@echo "   Actix Web O11Y "
	@echo ""
	@echo "Available targets:"
	@echo "Rust commands:"
	@echo "  all      : Build the project (default)"
	@echo "  build    : Build the project in debug mode"
	@echo "  release  : Build the project in release mode"
	@echo "  run      : Run the project"
	@echo "  test     : Run tests"
	@echo "  lint     : Run clippy for linting"
	@echo "  format   : Format code using rustfmt"
	@echo "  clean    : Clean build artifacts"
	@echo "  doc      : Generate documentation"
	@echo "  outdated : Check for outdated dependencies"
	@echo "  update   : Update dependencies"
	@echo "  info     : Show project information"
	@echo "Git commands:"
	@echo "  git-status : Show Git status"
	@echo "  git-add    : Stage all changes"
	@echo "  git-commit : Commit staged changes (prompts for message)"
	@echo "  git-push   : Push commits to remote repository"
	@echo "  git-pull   : Pull changes from remote repository"
	@echo "  git-log    : Show recent Git log (last 10 commits)"
	@echo "Advanced Git commands:"
	@echo "  git-amend          : Amend the last commit"
	@echo "  git-stash          : Stash current changes"
	@echo "  git-unstash        : Apply and remove the latest stash"
	@echo "  git-undo           : Undo the last commit, keeping changes"
	@echo "  git-cleanup        : Clean up merged branches"
	@echo "  git-conflicts      : List files with merge conflicts"
	@echo "Docker commands:"
	@echo "  docker-up          : Start docker-compose services"
	@echo "  docker-down        : Stop docker-compose services"
	@echo "  docker-build       : Build docker-compose services"
	@echo "  docker-logs        : Tail logs for docker-compose services"
	@echo "  help               : Show this help message"


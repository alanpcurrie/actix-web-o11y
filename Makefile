# Makefile for Rust project

# Variables
CARGO := cargo
TARGET_DIR := target
RELEASE_DIR := $(TARGET_DIR)/release
DEBUG_DIR := $(TARGET_DIR)/debug
GIT := git

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

# Help target
.PHONY: help
help:
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
	@echo "Basic Git commands:"
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
	@echo "  git-branch-cleanup : Remove local branches that no longer exist on remote"
	@echo "  git-conflict-files : List files with merge conflicts"
	@echo "  git-graph          : Show a colorful graph of the Git history"
	@echo "  git-blame-history  : Show the blame history of a file"
	@echo "  git-search-commits : Search for a term in all commit messages"
	@echo "  help               : Show this help message"

PYTHON3       := python3
POETRY        := poetry
PYTHON3_GUARD := $(shell command -v ${PYTHON3} 2> /dev/null)
POETRY_GUARD  := $(shell command -v ${POETRY} 2> /dev/null)

.PHONY: check-python3
check-python3: ## Check if python3 is installed 🐍
	@echo "+ $@"
ifndef PYTHON3_GUARD
	$(error "python3 is not available please install it")
endif
	@echo "Found ${PYTHON3} ✔️"

.PHONY: check-poetry
check-poetry: ## Check if poetry is installed 🐍
	@echo "+ $@"
ifndef POETRY_GUARD
	$(error "poetry is not available, please visit https://python-poetry.org/docs/#installation")
endif
	@echo "Found ${POETRY_GUARD} ✔️"

.PHONY: install-dependencies ➤
install-dependencies:
	poetry install

.PHONY: run ➤
run:
	poetry run python main.py

.DEFAULT_GOAL := find-target
.PHONY: find-target
find-target:
	@grep --no-filename -E '.PHONY:[[:space:]].*➤' $(MAKEFILE_LIST) \
	| sed -n -E "s/[[:space:]]+➤//p" \
	| sed -n -E "s/.PHONY:[[:space:]]+//p" \
	| fzf \
	| xargs -I '{}' make {}

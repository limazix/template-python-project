SHELL:=/bin/bash
PYTHON_RUNNER=poetry run

PYTHON_TOOLS=tools
PYTHON_TESTS=tests
PYTHON_SCRIPTS=$(PYTHON_TOOLS) $(PYTHON_TESTS)

DOCS_PATH=./docs/docstrings
DOCS_OVERVIEW="README.md"
REPO_URL="https://github.com/limazix/template-python-project"

commit:
	@git add --interactive
	@$(PYTHON_RUNNER) cz commit

install:
	@poetry install

update:
	@poetry update

clean:
	@poetry cache clean

lint:
	@$(PYTHON_RUNNER) black $(PYTHON_SCRIPTS) --check
	@$(PYTHON_RUNNER) flake8 $(PYTHON_SCRIPTS) --statistics

test:
	@$(PYTHON_RUNNER) pytest

test-watch:
	@$(PYTHON_RUNNER) pytest -f

coverage:
	@$(PYTHON_RUNNER) pytest --cov=$(PYTHON_TOOLS)

docs:
	mkdir -p $(DOCS_PATH)
	@$(PYTHON_RUNNER) lazydocs \
		--output-path=$(DOCS_PATH) \
		--overview-file=$(DOCS_OVERVIEW) \
		--src-base-url=$(REPO_URL)/blob/main \
		$(PYTHON_TOOLS)

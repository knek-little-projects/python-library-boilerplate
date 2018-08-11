PYTHON?=python3
PYTHONPATH=./
SOURCE_DIR=./${library_name}
TESTS_DIR=./tests
COVERAGE?=coverage
COVERAGE_HTML_REPORT_DIR?=./htmlcov/
PYCODESTYLE?=pycodestyle
PYPI_NAME?=pypi
all: help

help:
	@echo "clean        - remove artifacts"
	@echo "build        - build python package"
	@echo "install      - install python package"
	@echo "test         - run tests"
	@echo "coverage     - run tests with code coverage"
	@echo "htmlcoverage - run tests with code coverage and generate html report"
	@echo "check        - check code style"
	@echo "sdist        - make source distribution tarball"
	@echo "upload       - upload source distribution tarball to local PYPI"
	@echo "bump         - patch version"

clean: clean-pyc clean-build clean-test

clean-pyc:
	@find . -name '*.py[cod]' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -rf {} +
	@find . -name '*$py.class' -exec rm -rf {} +

clean-build:
	@rm -rf build/
	@rm -rf dist/
	@rm -rf .eggs/
	@find . -name '*.egg-info' -exec rm -rf {} +
	@find . -name '*.egg' -exec rm -f {} +

clean-test:
	@rm -rf $(COVERAGE_HTML_REPORT_DIR)

build:
	@PYTHONPATH=$(PYTHONPATH) $(PYTHON) setup.py build

install:
	@PYTHONPATH=$(PYTHONPATH) $(PYTHON) setup.py install

test: clean
	@PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m pytest $(TESTS_DIR) -v

coverage: clean
	@PYTHONPATH=$(PYTHONPATH) $(COVERAGE) run --branch --source=$(SOURCE_DIR) -m pytest $(TESTS_DIR)
	@$(COVERAGE) report

htmlcoverage: coverage
	@$(COVERAGE) html

check: pycodestyle

pycodestyle:
	@$(PYCODESTYLE) $(SOURCE_DIR) $(TESTS_DIR)

sdist:
	$(PYTHON) ./setup.py sdist

upload:
	$(PYTHON) ./setup.py sdist upload -r $(PYPI_NAME)

bump:
	@bumpversion --tag patch

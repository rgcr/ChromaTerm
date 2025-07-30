.PHONY: help clean build test test-pypi publish verify-install

help:
	@echo "ChromaTerm2 Package Management"
	@echo ""
	@echo "Available targets:"
	@echo "  clean        - Clean build artifacts"
	@echo "  build        - Build the package"
	@echo "  test         - Run tests"
	@echo "  test-pypi    - Upload to TestPyPI"
	@echo "  publish      - Upload to production PyPI"
	@echo "  verify-install - Test installation from PyPI"
	@echo "  all          - Clean, build, test, and publish to TestPyPI"

clean:
	@echo "Cleaning build artifacts..."
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete

build: clean
	@echo "Building package..."
	uv run python -m build

test:
	@echo "Running tests..."
	uv run pytest

test-pypi: build
	@echo "Uploading to TestPyPI..."
	@echo "Make sure you have configured your TestPyPI token:"
	@echo "  uv run twine configure --repository testpypi --username __token__ --password <your-token>"
	uv run twine upload --repository testpypi dist/*
	@echo ""
	@echo "To install from TestPyPI:"
	@echo "  pip install --index-url https://test.pypi.org/simple/ chromaterm2"

publish: build
	@echo "Uploading to production PyPI..."
	@echo "Make sure you have configured your PyPI token:"
	@echo "  uv run twine configure --repository pypi --username __token__ --password <your-token>"
	@read -p "Are you sure you want to publish to production PyPI? (y/N): " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		uv run twine upload dist/*; \
	else \
		echo "Publishing cancelled."; \
	fi

verify-install:
	@echo "Testing installation from PyPI..."
	@echo "Creating temporary virtual environment..."
	python -m venv /tmp/chromaterm2_test_env
	/tmp/chromaterm2_test_env/bin/pip install chromaterm2
	@echo "Testing installation..."
	/tmp/chromaterm2_test_env/bin/ct --version
	@echo "Cleaning up..."
	rm -rf /tmp/chromaterm2_test_env
	@echo "Installation test complete!"

all: clean build test test-pypi
	@echo "Build and TestPyPI upload complete!"
	@echo "Next steps:"
	@echo "1. Test the TestPyPI installation"
	@echo "2. Run 'make publish' when ready for production"

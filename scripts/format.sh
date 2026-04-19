#!/bin/bash
set -o pipefail

# Code Quality Format Script - MODIFIES FILES
# Automatically fixes code style issues, then runs quality checks.
#
# Usage: ./scripts/format.sh
# Prerequisites: uv sync --group dev

echo "1. Sorting imports with isort..."
uv run isort backend/ main.py

echo ""
echo "2. Formatting code with Black..."
uv run black backend/ main.py

FAILED=0

echo ""
echo "3. Running flake8 linting..."
uv run flake8 backend/ main.py || FAILED=1

echo ""
echo "4. Running mypy type checking..."
uv run mypy backend/ main.py || FAILED=1

echo ""
if [ $FAILED -ne 0 ]; then
    echo "Some checks reported issues (see above)"
    exit 1
fi

echo "All code quality checks passed!"

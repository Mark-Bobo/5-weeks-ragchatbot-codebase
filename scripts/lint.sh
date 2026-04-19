#!/bin/bash
set -o pipefail

# Code Quality Lint Script - READ-ONLY CHECKS
# Verifies code quality without making any changes to files.
#
# Usage: ./scripts/lint.sh
# Prerequisites: uv sync --group dev
# Exit codes: 0 = all checks pass, non-zero = issues found

FAILED=0

echo "1. Running flake8 linting..."
uv run flake8 backend/ main.py || FAILED=1

echo ""
echo "2. Running mypy type checking..."
uv run mypy backend/ main.py || FAILED=1

echo ""
echo "3. Checking import sorting..."
uv run isort --check-only --diff backend/ main.py || FAILED=1

echo ""
echo "4. Checking code formatting..."
uv run black --check --diff backend/ main.py || FAILED=1

echo ""
if [ $FAILED -ne 0 ]; then
    echo "Code quality checks FAILED"
    exit 1
fi

echo "All code quality checks passed!"

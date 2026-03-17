#!/bin/bash
set -e

# Run all tests
echo "--- Running All Tests ---"

echo "1. ShellCheck (Linting)"
bash tests/lint.sh
echo ""

echo "2. Package Check (PKGBUILD and Packages)"
bash tests/package-check.sh
echo ""

echo "--- All Tests Passed! ---"

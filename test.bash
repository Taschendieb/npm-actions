#!/bin/bash

# Set the package and branch details
PACKAGE_NAME="@ronin/compiler"
BRANCH_NAME="corny/remove-experimental"

# Output the branch name
echo "Branch Name: $BRANCH_NAME"

# Retrieve all versions of the package in JSON format
VERSIONS=$(npm view $PACKAGE_NAME versions --json)

# Check if any versions were retrieved
if [ -z "$VERSIONS" ]; then
  echo "No versions found for $PACKAGE_NAME."
  exit 0
fi

# Filter versions matching the branch-specific pattern
MATCHING_VERSIONS=$(echo "$VERSIONS" | tr -d '[]" ' | tr ',' '\n' | grep -F -- "-${BRANCH_NAME}-experimental")

# Check if any matching versions were found
if [ -z "$MATCHING_VERSIONS" ]; then
  echo "No versions to unpublish for branch $BRANCH_NAME."
  exit 0
fi

# Output the matching versions to GitHub Actions output
echo "versions=$MATCHING_VERSIONS" >> $GITHUB_OUTPUT

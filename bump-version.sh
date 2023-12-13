#!/bin/bash

# Get the current version from package.json
CURRENT_VERSION=$(node -pe "require('./package.json').version")

# Extract major, minor, and patch versions
MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
PATCH=$(echo $CURRENT_VERSION | cut -d. -f3)

# Increment the patch version
PATCH=$((PATCH + 1))

# Reset patch to 0 and increment the minor version when patch reaches 10
if [ $PATCH -eq 10 ]; then
  PATCH=0
  MINOR=$((MINOR + 1))
fi

# If minor version reaches 10, reset both minor and patch to 0 and increment major
if [ $MINOR -eq 10 ]; then
  MINOR=0
  PATCH=0
  MAJOR=$((MAJOR + 1))
fi

# Set the new version
NEW_VERSION="$MAJOR.$MINOR.$PATCH"

# Update the version in package.json without creating a Git commit or tag
sed -i.bak "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" package.json

# Display the updated version
echo "Bumped version to $NEW_VERSION"

#!/bin/bash

BASE_VERSION="0.0.4-alpha."

# Get the current version from package.json
CURRENT_VERSION=$(node -pe "require('./package.json').version")

# Extract the numeric part of the alpha version
ALPHA_NUMERIC=$(echo $CURRENT_VERSION | cut -d- -f2 | awk -F. '{print $2 "." $3}')

# Increment the second part of the alpha versionssssss
IFS='.' read -r -a ALPHA_PARTS <<< "$ALPHA_NUMERIC"
ALPHA_PARTS[1]=$((ALPHA_PARTS[1] + 1))

# Check if the second part reached 10 and increment the first part
if [ ${ALPHA_PARTS[1]} -eq 10 ]; then
  ALPHA_PARTS[0]=$((ALPHA_PARTS[0] + 1))
  ALPHA_PARTS[1]=0
fi

# Set the new version
NEW_VERSION="${BASE_VERSION}${ALPHA_PARTS[0]}.${ALPHA_PARTS[1]}"

# Update the version in package.json without creating a Git commit or tag
sed -i.bak "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" package.json

# Display the updated version
echo "Bumped version to $NEW_VERSION"

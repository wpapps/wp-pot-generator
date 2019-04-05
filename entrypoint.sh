#!/bin/bash

# Note that this does not use pipefail
# because if the grep later doesn't match any deleted files,
# which is likely the majority case,
# it does not exit with a 0, and I only care about the final exit.
set -eo

# Allow some ENV variables to be customized
if [[ -z "$SLUG" ]]; then
	SLUG=${GITHUB_REPOSITORY#*/}
fi

if [[ -z "$PACKAGE_NAME" ]]; then
	echo "Set Package Name"
	exit 1
fi

if [[ -z "$SAVE_PATH" ]]; then
	echo "Set Pot File Save destination"
	exit 1
fi

if [[ -z "$DOMAIN" ]]; then
	echo "Set Text Domain"
	exit 1
fi

if [[ -z "$USER" ]]; then
	echo "Set Text User (WordPress.org username / wordpress.org email)"
	exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable"
	exit 1
fi


if [[ -z "$HEADERS" ]]; then
	echo "Set the GITHUB_TOKEN env variable"
	exit 1
fi

cd "$GITHUB_WORKSPACE"
ls -l
wp i18n make-pot . "$SAVE_PATH" --user="$USER" --allow-root --slug="$SLUG" --package-name="$PACKAGE_NAME" --headers='$HEADERS'
ls -l
cat $SAVE_PATH

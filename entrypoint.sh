#!/bin/bash

# Note that this does not use pipefail
# because if the grep later doesn't match any deleted files,
# which is likely the majority case,
# it does not exit with a 0, and I only care about the final exit.
set -eo

# Allow some ENV variables to be customized
if [[ -z "$ITEM_SLUG" ]]; then
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
	#echo "Set Text Domain"
	#exit 1
	DOMAIN = $ITEM_SLUG
fi

#if [[ -z "$USER" ]]; then
#	echo "Set Text User (WordPress.org username / wordpress.org email)"
#	exit 1
#fi

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable"
	exit 1
fi

if [[ -z "$HEADERS" ]]; then
	HEADERS = ''
fi

echo $ITEM_SLUG
echo $DOMAIN

## Update Git Config.
git config --global user.email "wppotgenerator+github@gmail.com" && git config --global user.name "WordPress Pot Generator on GitHub"

cd "$GITHUB_WORKSPACE"

# Generate POT File
#wp i18n make-pot . "$SAVE_PATH" --user="$USER" --slug="$SLUG" --package-name="$PACKAGE_NAME" --headers="$HEADERS" --allow-root
wp i18n make-pot . "$SAVE_PATH" --slug="$ITEM_SLUG" --package-name="$PACKAGE_NAME" --headers="$HEADERS" --allow-root

# ls -l | cat $SAVE_PATH | echo ${GITHUB_REF} | echo $GITHUB_REF

# Update In Github
git add -A
git commit -m "Pot File Updated"
git remote set-url origin https://$GITHUB_TOKEN@github.com/${GITHUB_REPOSITORY}.git
git push --set-upstream origin $GITHUB_REF -f

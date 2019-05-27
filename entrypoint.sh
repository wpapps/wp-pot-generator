#!/bin/bash

set -eo

if [[ -z "$ITEM_SLUG" ]]; then
	ITEM_SLUG=${GITHUB_REPOSITORY#*/}
fi

if [[ -z "$SAVE_PATH" ]]; then
	echo "Set Pot File Save destination"
	exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable"
	exit 1
fi

## Optional ENV Vars
if [[ -z "$DOMAIN" ]]; then
	DOMAIN=${ITEM_SLUG}
fi

## Update Git Config.
git config --global user.email "wppotgenerator+github@gmail.com" && git config --global user.name "WordPress Pot Generator on GitHub"

cd "$GITHUB_WORKSPACE"
wp i18n make-pot . "$SAVE_PATH" --slug="$ITEM_SLUG" --package-name="$PACKAGE_NAME" --headers="$HEADERS" --allow-root

# Update In Github
git add -A
git commit -m "Pot File Updated"
git remote set-url origin https://$GITHUB_TOKEN@github.com/${GITHUB_REPOSITORY}.git
git push --set-upstream origin $GITHUB_REF -f

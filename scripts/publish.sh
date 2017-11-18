#!/bin/bash
git config --global user.email simona.cotin@microsoft.com
git config --global user.name simonaco-circle

git checkout -b "$1"
git merge master
git commit -am "$CIRCLE_BRANCH build#$CIRCLE_BUILD_NUM"
git push --force --set-upstream origin $1


# $AZURE_REPO_URL needs to be set in your projects Variables section
# and include both username and password, e.g: https://username:password@site.scm.azurewebsites.net:443/site.git

# Clone Azure repository
git clone $AZURE_REPO_URL ~/azure

# change into the local azure directory
cd ~/azure

# delete local repository azure contents
rm -rf *

# Copy /dist folder contents (our app)
cp -rf ~/repo/dist/* .

git add -A
git commit --all --author "simonaco-cricle <$CI_COMMITTER_EMAIL>" --message "bla ($CIRCLE_BUILD_NUM)"

# Push changes to Azure
git push origin master

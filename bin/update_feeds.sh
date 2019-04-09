#!/bin/bash

REPO_ORG=swcarpentry
REPO_NAME=website
GITHUB_PAT_USER=fmichonneau # user who generated the GITHUB PAT used here

cd .. &&
    mkdir feed-data &&
    cd feed-data &&
    curl --remote-name-all https://feeds.carpentries.org/swc_{past,upcoming}_workshops.json &&
    find . -name '*.json' -exec cp {} ../"$REPO_NAME"/_data/ \;

cd ../"$REPO_NAME"  || exit

git remote add deploy https://"$GITHUB_PAT_USER":"$GITHUB_PAT"@github.com/"$REPO_ORG"/"$REPO_NAME".git

git checkout gh-pages
git add _data/*.json
git commit -m "[ci skip] update workshop data"
git push deploy gh-pages

rm -rf ../feed-data

#!/bin/bash

set -e

./bin/posts.sh content/**/*.md
./bin/index.sh content/**/*.md

touch package.json # Stupid gh-pages fails if there's no package.json ¬¬

echo "Deploying..."
npx gh-pages -d './content' --nojekyll

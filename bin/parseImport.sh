#!/usr/bin/env bash

# The command below looks for the syntax: ![[path/filename]]
# and replaces it with the contents of file "path/filename.md".
# And it does that recursively
# Inspired by https://stackoverflow.com/a/18517316/3163120

perl -ne 's#^!\[\[(.+?)\]\]#`'$0' "$1.md"`#e;print' "$@" | \
sed -E 's#(^|\s|[^\]\()(https?://[^ )\\]+)#\1<\2>#g' "$@" # sed command to parse raw URLs in markdown files and then wrap them in `<...>` tags
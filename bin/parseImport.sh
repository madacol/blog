#!/usr/bin/env bash

# The command below looks for the syntax: ![[path/filename]]
# and replaces it with the contents of file "path/filename.md".
# And it does that recursively
# Inspired by https://stackoverflow.com/a/18517316/3163120

perl -ne 's#^!\[\]\((.+?)\)#my $path = $1; $path =~ s/%20/ /g; `'"$0"' "$path"`#e;print' "$@"

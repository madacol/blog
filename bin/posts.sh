#!/usr/bin/env bash

# Convert markdown files to HTML

for file in "$@";
do

  outputFile=${file%.*}.html
  echo "Generating \"$outputFile\""

  # replace file extension in internal links (e.g. [link](file.md) -> [link](file.html))
  sed -E 's#\[(.*?)\]\((.+?)\.md\)#[\1](\2.html)#g' "$file" > /dev/shm/parsedContent.md

  title=$(sed -n 's/^# //p' "$file" | head -n 1)

  pandoc <(./bin/parseImport.sh /dev/shm/parsedContent.md) \
    -o "$outputFile" \
    -f markdown \
    --pdf-engine wkhtmltopdf \
    --pdf-engine-opt=--enable-local-file-access \
    --resource-path=$(dirname "$file") \
    --css style.css \
    --standalone \
    --metadata pagetitle="$title" \
    --highlight-style espresso \
    --mathml
    
done

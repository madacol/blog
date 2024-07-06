#!/usr/bin/env bash

# Convert markdown files to HTML

runFolder=$(pwd)

for file in "$@";
do

  echo "Generating \"$outputFile\""

  # replace file extension in internal links (e.g. [link](file.md) -> [link](file.html))
  sed -E 's#\[(.*?)\]\((.+?)\.md\)#[\1](\2.html)#g' "$file" > /dev/shm/parsedContent.md

  outputFile=${file%.*}.html
  title=$(sed -n 's/^# //p' "$file" | head -n 1)

  pandoc <(./bin/parseImport.sh /dev/shm/parsedContent.md) \
    -o "$outputFile" \
    -f markdown \
    --pdf-engine wkhtmltopdf \
    --pdf-engine-opt=--enable-local-file-access \
    --resource-path=$(dirname "$file") \
    --css $runFolder/content/style.css \
    --self-contained \
    --metadata pagetitle="$title" \
    
done

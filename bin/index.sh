#!/usr/bin/env bash

set -e

# Construct the index.html file

echo "Generating index.html"

htmlDoc="<!DOCTYPE html>
<html>
<head>
  <meta charset=\"utf-8\">
  <title>Madacol's Blog</title>
  <link rel=\"stylesheet\" href=\"style.css\">
  <style>
    article {
      margin-bottom: 5em;

      .content {
        & > .summary {
          display: block;
        }
        & > details > summary {
          cursor: pointer;
        }
        &:has(> details[open]) {
          & > .summary {
            display: none;
          }
          & > details > summary {
            display: none;
          }
        }
      }
    }
  </style>
</head>
<body>
"
# Initialize an empty array to store the files
date_files=()

# Iterate over the arguments passed to the script
for file in "$@"
do
  date=$(sed -n '/^---$/,/^---$/p' "$file" | sed -n 's/^date: //p')

  # Append the file and its latest commit date to the files array
  date_files+=("$date $file")
done

# Sort the files array in reverse order based on the commit date
mapfile -t sorted_files < <(printf '%s\n' "${date_files[@]}" | sort -r | cut -d ' ' -f 2-)

for inputFile in "${sorted_files[@]}"
do
    echo "Parsing \"$inputFile\""

    title=$(sed -n 's/^# //p' "$inputFile" | head -n 1)
    date=$(sed -n 's/^date: //p' "$inputFile" | head -n 1)
    content=$(./bin/parseImport.sh "$inputFile" | sed '1,/^# /d' | pandoc -f markdown -t html)
    summary=$(./bin/parseImport.sh "$inputFile" | sed '1,/^# /d' | head -c +500 | pandoc -f markdown-tex_math_dollars -t html)
    relativePath=$(echo "$inputFile" | sed 's#content/##' | sed 's/"/%22/g')
    href=${relativePath%.*}.html
    htmlDoc+="
      <article>
        <h1><a href=\"$href\">$title</a></h1>
        <time datetime=\"$date\">$date</time>
        <div class=\"content\">
          <div class=\"summary\">$summary ...</div>
          <details>
            <summary>Read more</summary>
            $content
          </details>
        </div>
      </article>"
done

htmlDoc+="
</body>
</html>
"

echo "$htmlDoc" > content/index.html

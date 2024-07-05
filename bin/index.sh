#!/usr/bin/env bash

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

mapfile -t files < <(git ls-files -z "$@" | xargs -0 -I{} sh -c 'git log --follow --format="%ad {}" --date=short -- "{}" | tail -n 1' | sort -r | cut -d' ' -f2-)

for inputFile in "${files[@]}";
do
    echo "Parsing \"$inputFile\""

    title=$(sed -n 's/^# //p' "$inputFile" | head -n 1)
    date=$(sed -n 's/^date: //p' "$inputFile" | head -n 1)
    content=$(sed '1,/^# /d' "$inputFile" | pandoc -f markdown -t html)
    summary=$(sed '1,/^# /d' "$inputFile" | head -c +500 | pandoc -f markdown-tex_math_dollars -t html)
    filename=$(basename "$inputFile")
    href=${filename%.*}.html
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

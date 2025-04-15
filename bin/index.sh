#!/usr/bin/env bash

set -e

# Construct the index.html file

echo "Generating index.html"

htmlDoc="<!DOCTYPE html>
<html>
<head>
  <meta charset=\"utf-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=yes\" />
  <title>Madacol's Blog</title>
  <link rel=\"stylesheet\" href=\"style.css\">
  <style>
    article {
      margin-bottom: 5em;

      & > iframe {
        min-height: 200px;
        border: none;
        width: 100%;

        &:not(.expanded) {
          height: 30vh;
          overflow: hidden;
        }
      }
      & > details > summary {
        cursor: pointer;
      }
    }
  </style>
  <script>
    function resizeIframe(iframe) {
      iframe.contentDocument.getElementsByTagName('h1')[0].remove();
      iframe.contentDocument.body.style.padding = '0';
    }
    function expandPost(summary) {
      const details = summary.parentElement;
      const iframe = details.parentElement.querySelector('iframe');
      details.remove();
      iframe.classList.add('expanded');
      iframe.height = iframe.contentDocument.documentElement.scrollHeight;
      iframe.scrolling = 'auto';
    }
  </script>
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

    titleHtml=$(sed -n '/^# /p' "$inputFile" | head -n 1 | pandoc -f markdown -t html)
    date=$(sed -n 's/^date: //p' "$inputFile" | head -n 1)
    relativePath=$(echo "$inputFile" | sed 's#content/##' | sed 's/"/%22/g')
    href=${relativePath%.*}.html
    htmlDoc+="
      <article>
        <a href=\"$href\">$titleHtml</a>
        <time datetime=\"$date\">$date</time>
        <iframe
          src=\"$href\"
          onload=\"resizeIframe(this)\"
          scrolling=\"no\"
          loading=\"lazy\"
        ></iframe>
        <details>
          <summary onclick=\"expandPost(this)\">Read more</summary>
        </details>
      </article>"
done

htmlDoc+="
</body>
</html>
"

echo "$htmlDoc" > content/index.html

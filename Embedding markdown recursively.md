---
tags: english, tutorial, markdown
---

# Embedding markdown recursively

Remixing [@Oliver Matthews' answer][1]. I made it work recursively but instead using a wikilink-like syntax `![[filepath]]` that gets replaced with `filepath.md` content

## Setup

Create the script **parseMd.sh**

```bash
#!/usr/bin/env bash
perl -ne 's#^!\[\[(.+?)\]\].*#`'$0' "$1.md"`#e;print' "$@"
```

```bash
chmod +x parseMd.sh
```

## Using it

To embed `path/filename.md` use the syntax `![[path/filename]]`

Now parse the main file

```bash
./parseMd.sh main.md > result.md
```

To export directly to pdf, using pandoc

```bash
pandoc <(./parseMd.sh main.md) -o result.pdf --pdf-engine wkhtmltopdf \
  --css styles.css \
  -V margin-top=11mm \
  -V margin-bottom=11mm \
  -V margin-left=11mm \
  -V margin-right=11mm
```

More info on using pandoc to [[Export Markdown to PDF]]

## Resources

- [Markdown and including multiple files](https://stackoverflow.com/questions/4779582/markdown-and-including-multiple-files/73131038#73131038)
- [Embedding one markdown document in another](https://stackoverflow.com/questions/18438907/embedding-one-markdown-document-in-another/73130935#73130935)

  [1]: https://stackoverflow.com/a/18517316/3163120

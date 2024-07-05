---
tags: english, tutorial, markdown
date: 2022-07-26
---

# Export Markdown to PDF

## Install dependencies

```bash
sudo apt-get install pandoc wkhtmltopdf
```

## Export to PDF

```bash
pandoc README.md -o README.pdf --pdf-engine wkhtmltopdf \
  --css styles.css \
  -V margin-top=11mm \
  -V margin-bottom=11mm \
  -V margin-left=11mm \
  -V margin-right=11mm \
```

### Css template

```css
html, body {
  font-family: Arial, Helvetica, sans-serif;
  line-height: 1.5;
  font-size: 18px;
}
h1,h2,h3 {
  font-weight: bold;
}
h1 {
  padding-top: 0;
  margin-top: 0;
  border-bottom: 1px solid black;
}
h2 {
  padding-top: 15px;
  border-top: 1px solid black;
}
blockquote, code {
  padding: 0 1em;
  margin: 0;
  color: black !important;
  background-color: rgb(235, 235, 235);
}
.columnList ul{ margin: 0; }
```

To debug CSS styles, export to html instead by changing the extension `... -o README.html ...`

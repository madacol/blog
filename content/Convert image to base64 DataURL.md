---
title: Convert image to base64 DataURL
tags: english, tutorial, til, javascript, base64, scrapping, markdown
date: 2023-07-14
---

This function loads the image in a canvas and uses `canvas.ToDataURL(...)` to convert it to base64. But it doesn't work in all cases, for example, if the image is loaded from a different domain, it will throw a security error.

```js
function getBase64Image(img) {
  const canvas = document.createElement("canvas");
  const ctx = canvas.getContext("2d");
  ctx.drawImage(img, 0, 0);
  const dataURL = canvas.toDataURL("image/png");
  return dataURL;
}
```

This one works in more cases because it re-fetches the `img.src` as a blob and then converts it to base64, avoiding the security error of using the canvas.

```js
const getBase64FromUrl = async (url) => {
  const data = await fetch(url);
  const blob = await data.blob();
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.readAsDataURL(blob);
    reader.onloadend = () => {
      const base64data = reader.result;
      resolve(base64data);
    }
  });
}
```
---

As a bonus, this one uses both functions before to read all images in the page and uses the first function if it works, otherwise it uses the second one, and returns a markdown image embedding of the image with its alt text as the title and the base64 as the source.

```js
const images = document.getElementsByTagName('img');
[...images].forEach(async img => {
  let base64;
  try {
    base64 = getBase64Image(img);
  } catch (error) {
    base64 = await getBase64FromUrl(img.src);
  };
  const markdown = `![${img.alt}](${base64})`;
  console.log(markdown, img);
})
```

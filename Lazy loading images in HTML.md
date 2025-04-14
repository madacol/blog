---
tags: knowledge, frontend, lazy-load, english
date: 2020-07-27
---

# Lazy loading images in HTML

To implement Lazy Loading to an `<img ... >` tag, add the attribute `loading=lazy`

```html
<img loading=lazy ... >
```

This will load the image when scrolling is near the viewport, using the [Intersection Observer API](https://developers.google.com/web/updates/2016/04/intersectionobserver)

## Further reading

- [Native image lazy-loading](https://web.dev/native-lazy-loading)

## What led to learning this

Accidentally: a rabbit hole that started at [Jason Crawford's github](https://github.com/jasoncrawford) and ended at an [issue in the owid-grapher repo](https://github.com/owid/owid-grapher/pull/422)

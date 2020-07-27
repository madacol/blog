# img lazy loading in html

To implement [[Lazy Loading]] to an `<img ... >` tag, add the attrbitue `loading=lazy`

    <img loading=lazy ... >

This will load the image when scrolling is near the viewport, using the [Intersection Observer API](https://developers.google.com/web/updates/2016/04/intersectionobserver)

## Further reading

- <https://web.dev/native-lazy-loading>

## Why learned this

- Accidentally: a rabbit hole that started at [Jason Crawford's github](https://github.com/jasoncrawford) and ended at <https://github.com/owid/owid-grapher/pull/422>

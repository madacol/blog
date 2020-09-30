---
tags: knowledge, web
---

# Open Graph Protocol

This is a standard that uses websites to tell external websites how a link preview should look

Works by defining `<meta/>` tags like `<meta property="og:{}" content="{}" />`

## Example

```html
<html prefix="og: https://ogp.me/ns#">
    <head>
        <title>The Rock (1996)</title>
        <meta property="og:title" content="The Rock" />
        <meta property="og:type" content="video.movie" />
        <meta property="og:url" content="https://www.imdb.com/title/tt0117500/" />
        <meta property="og:image" content="https://ia.media-imdb.com/images/rock.jpg" />
        ...
    </head>
...
</html>
```

## Further reading

- [Official documentation](https://ogp.me/)

## What led to learning this

- I Linked to [Bolivar Paralelo](https://bolivarparalelo.com/) in my [LinkedIn](https://www.linkedin.com/in/madacol/) and the preview was garbage

---
tags: english, tutorial, til, markdown
date: 2025-02-03
---

# Trick to execute markdown code blocks in the browser

*If you want to see how the examples work underneath, see the [markdown source](javascript:location.href = location.href.replace('.html', '.md'))*

---

Most markdown renderers allow you to mix html and markdown.\
We can take advantage of this to add html `<scripts>` elements that will get executed in the browser.

To execute code blocks and show the results below, add this script at the end of your markdown file:

```md
<!-- end of markdown file -->

<script>
    [...document.querySelectorAll('pre > code')].forEach(code => {
        const result = eval(code.innerText);

        // show result in a div after the code block
        const resultElement = document.createElement('div');
        resultElement.innerText = result;
        code.after(resultElement);
    })
</script>
```

### Example

```js
new Date();
```

<script>
    [...document.querySelectorAll('pre > code')].slice(-1).forEach(code => {
        const result = eval(code.innerText);

        // show result in a div after the code block
        const resultElement = document.createElement('div');
        resultElement.innerText = result;
        code.parentElement.after(resultElement);
    })
</script>

---

## How about drawing on a canvas?

I am trying to make some simulations in canvas because I want to see the results in real time.\
This script expects a function in the code blocks and passes the canvas so you can draw in them.

```md
<!-- end of markdown file -->

<script>
    [...document.querySelectorAll('pre > code')].forEach(code => {
        // Add a canvas after the code block
        const canvas = document.createElement("canvas");
        code.parentElement.after(canvas);
        const ctx = canvas.getContext('2d');

        // Run the code
        // Note: Code blocks must return a function so they can receive the canvas context and element as parameters
        const fn = eval(code.innerText);
        fn(ctx, canvas);
    })
</script>
```

### Example

```js
(ctx, canvas) => {
    canvas.width = 200;
    canvas.height = 200;
    canvas.style.backgroundColor = 'black';
    
    let x = Math.random() * canvas.width;
    let y = Math.random() * canvas.height;
    let dx = 4 * Math.random() * 2 - 1;
    let dy = 4 * Math.random() * 2 - 1;
    
    function animate() {
        ctx.fillStyle = 'rgba(0, 0, 0, 0.1)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        ctx.fillStyle = 'white';
        ctx.beginPath();
        ctx.arc(x, y, 5, 0, Math.PI * 2);
        ctx.fill();
        
        x += dx;
        y += dy;
        
        if (x < 0 || x > canvas.width) dx = -dx;
        if (y < 0 || y > canvas.height) dy = -dy;
        
        requestAnimationFrame(animate);
    }
    
    animate();
}
```

<script>
    [...document.querySelectorAll('pre > code')].slice(-1).forEach(code => {
        // Add a canvas after the code block
        const canvas = document.createElement("canvas");
        code.parentElement.after(canvas);
        const ctx = canvas.getContext('2d');

        // Run the code
        // Note: Code blocks must return a function so they can receive the canvas context and element as parameters
        const fn = eval(code.innerText);
        fn(ctx, canvas);
    });
</script>

---

## Run only specific code blocks

We can mark the code blocks we want to run with a comment like `// run-on-canvas` at the top of the block.\
And filter them with this line: `.filter(code => code.children[0].innerText === '// run-on-canvas')`

```md
<!-- end of markdown file -->

<script>
    [...document.querySelectorAll('pre > code')]
    .filter(code => code.children[0].innerText === '// run-on-canvas')
    .forEach(code => {
        // Add a canvas after the code block
        const pre = code.parentElement;
        const canvas = document.createElement("canvas");
        pre.after(canvas);
        const ctx = canvas.getContext('2d');

        // Run the code
        const fn = eval(code.innerText);
        fn(ctx, canvas);

        // Remove tag
        // code.childNodes[0].remove(); // remove tag
        // code.childNodes[0].remove(); // remove extra line
    })
</script>
```

You may have noticed that this script has code to remove the `// run-on-canvas` tag from the blocks, but I commented that out so you can see which blocks were tagged in the examples below.

### Example

```js
// run-on-canvas
ctx => {
    ctx.fillStyle = 'blue';
    ctx.fillRect(10, 10, 100, 50);
}
```

```js
// this block does not run
ctx => {
    ctx.fillStyle = 'red';
    ctx.fillRect(10, 10, 100, 50);
}
```

<script>
    [...document.querySelectorAll('pre > code')].slice(-2)
    .filter(code => code.children[0].innerText === '// run-on-canvas')
    .forEach(code => {
        // Add a canvas after the code block
        const pre = code.parentElement;
        const canvas = document.createElement("canvas");
        pre.after(canvas);
        const ctx = canvas.getContext('2d');

        // Run the code
        const fn = eval(code.innerText);
        fn(ctx, canvas);

        // Remove tag
        // code.childNodes[0].remove(); // remove tag
        // code.childNodes[0].remove(); // remove extra line
    })
</script>

This last code block does not run because it lacks the `// run-on-canvas` tag.

---

## Notes

Scripts in this post are not executed "as is":

- They are not at the end of the file and are placed after their examples.
- They are modified to only affect their examples instead of all code blocks.

You can see the markdown source of this post here: [markdown source](javascript:location.href = location.href.replace('.html', '.md'))

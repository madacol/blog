---
tags: english, explorable explanation
date: 2025-01-28
---

# Rumors dynamics pre vs post internet

I have the hypothesis that the popular believing strategy of *trusting rumors heard from multiple sources* do not work as well in the internet age because a single source can easily broadcast the same message through multiple channels (influencers, bots, etc), creating an illusion of independent sources. While in pre-internet times, hearing the same rumor from different people often meant genuine independent corroboration, today's interconnected networks allow misinformation to rapidly propagate through multiple paths while still originating from a single unreliable source.

My goal is to create a model to simulate the dynamics of rumors in a network of agents.

Let's start simple, and we'll add complexity as we go.

Here's a simple model of a network of agents. Each person has a belief about a rumor.

```js
// run-on-canvas
ctx => {
    class Person {
        constructor(name, belief) {
            this.name = name;
            this.belief = belief;
            this.x = Math.random() * canvas.width;
            this.y = Math.random() * canvas.height;
            this.edges = [];
            this.speed = 5;
            this.radius = 10;
        }

        addEdge(person) {
            this.edges.push(person);
        }

        draw(ctx) {
            // draw a filled rectangle
            ctx.fillStyle = this.belief ? 'blue' : 'red';
            ctx.fillRect(this.x, this.y, this.radius, this.radius);

            // draw edges
            this.edges.forEach(edge => {
                ctx.strokeStyle = 'white';
                ctx.lineWidth = 1;
                ctx.beginPath();
                ctx.moveTo(this.x + this.radius / 2, this.y + this.radius / 2);
                ctx.lineTo(edge.x + edge.radius / 2, edge.y + edge.radius / 2);
                ctx.stroke();
            });

        }

        update() {
            this.x += Math.random() * this.speed - this.speed / 2; if (this.x < 0) this.x = 0; /* handle edges */ if ((this.x + this.radius) > canvas.width) this.x = canvas.width - this.radius;
            this.y += Math.random() * this.speed - this.speed / 2; if (this.y < 0) this.y = 0; /* handle edges */ if ((this.y + this.radius) > canvas.height) this.y = canvas.height - this.radius;
            this.draw(ctx);
        }
    }

    const people = [
        new Person('Alice', true),
        new Person('Bob', false),
        new Person('Charlie', true),
        new Person('Dave', false),
        new Person('Eve', true),
        new Person('Frank', false),
        new Person('Grace', true),
        new Person('Hank', false),
        new Person('Ivy', true),
        new Person('Jack', false),
    ];

    // Add edges
    people[0].addEdge(people[1]);
    people[0].addEdge(people[2]);
    people[1].addEdge(people[3]);
    people[2].addEdge(people[4]);
    people[3].addEdge(people[5]);
    people[4].addEdge(people[6]);

    people.forEach(person => {
        person.draw(ctx);
    });

    // Draw edges
    people.forEach(person => {
        person.edges.forEach(edge => {
            ctx.strokeStyle = 'white';
            ctx.lineWidth = 1;
            ctx.beginPath();
            ctx.moveTo(person.x, person.y);
            ctx.lineTo(edge.x, edge.y);
            ctx.stroke();
        });
    });

    // Draw labels
    people.forEach(person => {
        ctx.fillStyle = 'white';
        ctx.font = '10px Arial';
        ctx.fillText(person.name, person.x, person.y);
    });

    function animate() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        people.forEach(person => {
            person.update();
        });

        requestAnimationFrame(animate);
    }

    animate();
}
```

---

```js
// run-on-canvas
ctx => {
    // Draw a filled rectangle
    ctx.fillStyle = 'blue';
    ctx.fillRect(10, 10, 100, 50);

    // Draw a stroked rectangle
    ctx.strokeStyle = 'yellow';
    ctx.strokeRect(30, 30, 100, 50);
}
```

test 2

```js
// run-on-canvas
ctx => {
    ctx.fillStyle = 'blue';
    ctx.fillRect(10, 10, 100, 50);
}
```


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
        code.childNodes[0].remove(); // remove tag
        code.childNodes[0].remove(); // remove extra line
    })
</script>

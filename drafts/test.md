## 1. Basic Linear Spread
First, let's look at the simplest possible spread - one person telling another in a line.

```javascript
// run-canvas
(ctx, canvas) => {
    canvas.width = 400;
    canvas.height = 100;

    class Person {
        constructor(x, y, informed = false) {
            this.x = x;
            this.y = y;
            this.informed = informed;
            this.draw();
        }

        draw() {
            ctx.beginPath();
            ctx.arc(this.x, this.y, 10, 0, Math.PI * 2);
            ctx.fillStyle = this.informed ? 'red' : 'blue';
            ctx.fill();
            ctx.stroke();
        }
    }

    // Create 5 people in a line
    const people = [];
    for (let i = 0; i < 5; i++) {
        people.push(new Person(50 + i * 80, 50, i === 0));
    }

    function animate() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        // Draw connections
        ctx.beginPath();
        for (let i = 0; i < people.length - 1; i++) {
            ctx.moveTo(people[i].x, people[i].y);
            ctx.lineTo(people[i + 1].x, people[i + 1].y);
        }
        ctx.stroke();

        // Draw people and spread information
        for (let i = 0; i < people.length - 1; i++) {
            if (people[i].informed) {
                people[i + 1].informed = true;
            }
            people[i].draw();
        }
        people[people.length - 1].draw();

        setTimeout(() => {
            console.log(people.map(p => p.informed));
            requestAnimationFrame(animate);
        }, 1000);
    }
    setTimeout(() => {
        animate();
    }, 1000);
}
```

## 2. Radial Spread
Now let's see how information spreads in all directions from a central source.

```javascript
// run-canvas
(ctx, canvas) => {
    canvas.width = 400;
    canvas.height = 400;

    class Person {
        constructor(x, y, distance, informed = false) {
            this.x = x;
            this.y = y;
            this.distance = distance;
            this.informed = informed;
        }

        draw() {
            ctx.beginPath();
            ctx.arc(this.x, this.y, 5, 0, Math.PI * 2);
            ctx.fillStyle = this.informed ? 'red' : 'blue';
            ctx.fill();
        }
    }

    // Create people in a radial pattern
    const people = [];
    const center = { x: 200, y: 200 };
    const rings = 3;
    const peoplePerRing = 8;

    // Add center person
    people.push(new Person(center.x, center.y, 0, true));

    // Add rings of people
    for (let ring = 1; ring <= rings; ring++) {
        for (let i = 0; i < peoplePerRing * ring; i++) {
            const angle = (i * 2 * Math.PI) / (peoplePerRing * ring);
            const radius = ring * 50;
            const x = center.x + radius * Math.cos(angle);
            const y = center.y + radius * Math.sin(angle);
            people.push(new Person(x, y, radius));
        }
    }

    function animate() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // Draw connections
        ctx.beginPath();
        ctx.strokeStyle = 'rgba(0,0,0,0.1)';
        for (let i = 0; i < people.length; i++) {
            for (let j = i + 1; j < people.length; j++) {
                const dx = people[i].x - people[j].x;
                const dy = people[i].y - people[j].y;
                const distance = Math.sqrt(dx * dx + dy * dy);
                if (distance < 60) {
                    ctx.moveTo(people[i].x, people[i].y);
                    ctx.lineTo(people[j].x, people[j].y);
                }
            }
        }
        ctx.stroke();

        // Update information spread
        for (let i = 0; i < people.length; i++) {
            if (people[i].informed) {
                for (let j = 0; j < people.length; j++) {
                    const dx = people[i].x - people[j].x;
                    const dy = people[i].y - people[j].y;
                    const distance = Math.sqrt(dx * dx + dy * dy);
                    if (distance < 60) {
                        people[j].informed = true;
                    }
                }
            }
            people[i].draw();
        }

        requestAnimationFrame(animate);
    }

    animate();
}
```

Would you like me to continue with more complex simulations? We could add:
1. Random network connections
2. Different probabilities of information acceptance
3. Information decay over time
4. Competing information sources
5. Network clusters and communities

Let me know which aspect you'd like to explore next!



<script>
    const runCanvases = [...document.querySelectorAll('div > pre > code')].filter(code => code.children[0].innerText === '// run-canvas');
    runCanvases.forEach(code => {
        const div = code.parentElement.parentElement;

        // Add canvas after code
        const canvas = document.createElement("canvas");
        div.after(canvas);
        const ctx = canvas.getContext('2d');

        // Run code
        const fn = eval(code.innerText);
        fn(ctx, canvas);
    })
</script>


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
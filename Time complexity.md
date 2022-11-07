---
tags: english, til, knowledge
---

# Time complexity

This is how scaling ability of algorithms are measured.

Let's assume we are dealing with algorithms that take a list of `n` items.

Now let's imagine an algorithm that just iterates the list and returns the greatest item.

This algorithm only needs to do a simple iteration to know the results, and if we double `n`, the  **execution time** also doubles.

If we tried to describe the mathematical function `ExecutionTime(n)`, the equation should look something like this:

<details style="margin-left: 1em;">
<summary>
<code>execution_time = n * constant</code>
</summary>
where <code>constant</code> includes any computation in the algorithm that doesn't change when increasing the size of the list (<code>n</code>).
</details>

We only care about how `n` directly affects the `execution_time`, so to simplify it we use the `O()` notation, in this example, its **time complexity** is `O(n)`,

Another way to think about it, if we increase the size of `n` by 10x, the `O()` notation tells us how the **execution time** will increase in comparison.\
If the algorithm has a **time complexity** of `O(n)`, we should expect the **execution time** to also increase by 10x, but if it is `O(n²)`, we should expect the **execution time** to increase by 100x instead, because `10² = 100`

## Other **time complexities**

- `O(1)`, its equation looks like this: `execution_time = constant`, because no matter how many more items you add, it will always take the same amount (`constant`) to run

- `O(log n)`, its equation looks like this: `execution_time = log(n) * constant`, if you increase `n` by 1024x, the **execution time** increases by just 10x (`log₂(1024) = 10`)

- `O(n²)`, its equation looks like this: `execution_time = n² * constant`, if you increase `n` by 3x, the **execution time** increases by 9x (`3² = 9`).

- [More examples, with common algorithms](https://en.wikipedia.org/wiki/Time_complexity#Table_of_common_time_complexities)

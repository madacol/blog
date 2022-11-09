---
tags: english, til, knowledge
---

# Time complexity

This is how scaling ability of algorithms are measured.

Let's assume we are dealing with algorithms that take a list of `n` items.\
For example, an algorithm that just iterates the list and returns the greatest item.\
This algorithm only needs to do a simple iteration to know the results, and if we double `n`, the  **execution time** also doubles.

If we tried to describe the mathematical function `ExecutionTime(n)` of that algorithm, the equation should look something like this:

<details style="margin-left: 1em;">
<summary>
<code>execution_time = n * constant</code>
</summary>
where <code>constant</code> includes any computation in the algorithm that doesn't change when increasing the size of the list (<code>n</code>).
</details>

We only care about how `n` directly affects the `execution_time`, so to simplify it we use the `O()` notation.\
In this example, its **time complexity** is `O(n)`, and it tells us that the **execution time** will change proportionally to (`n`).

## Example

If an algorithm has a **time complexity** of `O(n)`, and we increase the size of `n` by 10x, we should expect the **execution time** to also increase by 10x. But if the algorithm is `O(n²)`, we should expect the **execution time** to increase by 100x instead, because `10² = 100`

An example of an `O(n²)` algorithm:\
Produce all the ordered combinations of pairs from a list of `n` items. E.g.: input = `[A,B,C]`, which is size: 3\
output = `[[A,A], [A,B], [A,C], [B,A], [B,B], [B,C], [C,A], [C,B], [C,C]]`, which is size: 9 (3²)

## Other **time complexities**

- `O(1)`, its equation looks like this: `execution_time = constant`, because no matter how many more items you add, it will always take the same amount (`constant`) to run

- `O(log n)`, its equation looks like this: `execution_time = log(n) * constant`, if you increase `n` by 1024x, the **execution time** increases by just 10x (`log₂(1024) = 10`)

- `O(n²)`, its equation looks like this: `execution_time = n² * constant`, if you increase `n` by 3x, the **execution time** increases by 9x (`3² = 9`).

- [More examples, with common algorithms](https://en.wikipedia.org/wiki/Time_complexity#Table_of_common_time_complexities)

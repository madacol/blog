---
tags: english, til, knowledge
date: 2022-11-07
---

# Time complexity

This is how scaling ability of algorithms are described.

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

We only care about how `n` directly affects the `execution_time`

The scalability of this equation depends proportionally on `n`, so to describe its complexity we use the [Big O notation](https://en.wikipedia.org/wiki/Big_O_notation). In this example, its **time complexity** is `O(n)`, and it tells us that the **execution time** will change proportionally to (`n`).

If the `execution_time` equation had multiple complexities, e.g. `= 2n + n²`, we would only describe the biggest complexity (the one that increases faster), in this example it would be `z²`  since it dominates more and more as `n` increases, so in [Big O notation](https://en.wikipedia.org/wiki/Big_O_notation) it would be `O(n²)`

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


## Other notations

Big O notation describes the upper bound of the **time complexity**.\
There are other notations that describe the lower bound, or both bounds:

- `Ω(n)`, describes the lower bound of the **time complexity**.\
    E.g.: an algorithm that iterates a list of `n` items, and returns the first item that matches a condition.\
    If the first item matches the condition, the **execution time** will be `O(1)`, but if the first item doesn't match the condition, the **execution time** will be `O(n)`.\
    In this case, the **time complexity** is `Ω(1)`, because it will never be slower than `O(1)`
- `Θ(n)`, describes both the upper and lower bounds of the **time complexity**.

In general, these notations are called [Asymptotic Notations](https://learnxinyminutes.com/docs/asymptotic-notation/)


## Further reading

- [A more detailed explanation, but simpler than Wikipedia'](https://stackoverflow.com/questions/487258/what-is-a-plain-english-explanation-of-big-o-notation/487278#487278)
- [Wikipedia article](https://en.wikipedia.org/wiki/Time_complexity)
- [Big O notation](https://en.wikipedia.org/wiki/Big_O_notation)
- [Asymptotic Notations](https://learnxinyminutes.com/docs/asymptotic-notation/)

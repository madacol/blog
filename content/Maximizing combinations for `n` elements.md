---
tags: english, math
date: 2024-07-18
---

# Maximizing the *cartesian product* of `n` elements and how it relates to number bases

I was helping a friend in finding all possible combinations of schedules for a given set of courses, and it varied wildly the number of schedules each course had, most had 2 or 3, but others had more than 15 schedules, and when selecting the larger ones, the number of possible combinations blew up, and it was taking a looong time to compute.

## A Ridiculous Question

So then, for fun, I started to think that those were ~15 schedules in each of the 7 courses, which is roughly `15*7 = 105` schedules in total. So I asked myself, given a fixed number of schedules, How many courses should I distribute those `105` schedules so that it maximizes the number of possible combinations?

> Just to be clear, changing schedules from one course to another does not make sense at all. This is just a purely algorithmic / mathematical question.

## Hypothesis

I have thought in the past about common cases of permutations and combinations, like for example, in 10 coin flips the result that has more combinations is 5 heads and 5 tails, hence the more likely result.\
So I thought *"Hmm!, this looks familiar, I bet we can get the most combinations by distributing things evenly"*, so my first guess was to distribute schedules in a way that the number of courses were the same as the average number of schedules in the courses, ... roughly.

But that's just a wild guess!, I want to know the real answer!

## Testing

So naturally, I started testing my hypothesis. To make it simple, I started with `10` items. Let's test different ways of distributing the items

```python
>>> 5*5
25
>>> 4*4*2
32
>>> 3*3*3*1
27
>>> 2*2*2*2*2
32
>>> 3*3*4
36
```

So `3*3*4` is the winner, 3 groups of ~3.333 items, nice! my guess looks strong, both numbers are very close. But let's test it with more items, let's try `20` items.

```python
>>> 5*5*5*5
625
>>> 4*4*4*4*4
1024
>>> 3*3*3*3*3*3*2
1458
>>> 2*2*2*2*2*2*2*2*2*2
1024
```

*Uh oh!, my guess is not doing well*. The winner is now 7 groups of ~2.833 items, both numbers are now very different. And the average number of items, in both tests, are suspiciously close to `3`.

But *Hang on!*, the groups of 4 and 2 give the same combinations in both cases, is there a connection here?.\
Yes there is!, if we look closely, `4*4*4*4*4` and `2*2*2*2*2*2*2*2*2*2` is essentially the same thing, in fact, we can always replace `4` with `2*2`, because they are equivalent at both calculating the combinations *`4 = 2*2`* and preserving the number of items *`4 = 2+2`*.

Ok, so if 2 and 4, by logic are always the same regardless of scale, then `3` does indeed seem to be the sweet spot. It's interesting that I've never come across this fact.

## So what does this have to do with *number bases*?

Well, I wanted to test bigger numbers, but I got lazy, so I started to look for patterns, and I noticed that these calculations are equivalent to calculating numbers in other numerical systems with different bases.

For example, the number of combinations of `10` items distributed in groups of `2`, results in `5` groups of `2` items each, and that's equivalent to the number of numbers that can be represented with `5` digits in base `2`. This is because both scenarios involve making 5 independent choices, each with 2 options.

- So in the `5` groups of `2` items each, we get that the number of combinations is `2*2*2*2*2 = 32`.
- And in the case of `5` digits in base `2` we get that the number of numbers that can be represented is `2**5 = 32`.

    > Some of you might notice that `11111` is `31`, instead of `32`, but that's because `00000` is ignored, so after we count it back, we get `32`.


So these are the equivalences I found:

- The **number of groups** is equivalent to the **number of digits**.
- The **number of items in each group** is equivalent to the **base number**.
- And the **total number of items** is equivalent to __________ I have no idea, but I am going to call it *"units of information"*. **Edit**: maybe the technical term is [*"radix economy"*](https://en.wikipedia.org/wiki/Non-integer_base_of_numeration#:~:text=radix%20economy) (which is usually `base number * number of digits`)

For example, How many ~~items~~ *"units of information"* do we need in base 2 to represent the number `654987`?.\
But first, What do I mean by *"units of information"* exactly?, I mean something like the amount of symbols used, ... *What???*.\
Yes, base-2 has 2 possibilities, `1` or `0` in each digit, so the *"units of information"* in `n` bits is `2*n`, and that's the amount of symbols used to represent a number.

Ok, so to calculate the *"units of information"*, we need the number of bits needed to represent `654987`. Let's hunt it!

```python
>>> 2*2*2*2*2*2*2*2*2*2 # 10 bits
1024
>>> 2**10
1024
>>> 2**18
262144
>>> 2**19
524288 # almost there
>>> 2**20
1048576
```

*Yeah I know, I could have just used the logarithm*

```python
>>> math.log(654987, 2)
19.321106747160712
```

So we got `20` bits, and that means, that the *"units of information"* contained in 20 bits is `20*2 = 40` *"units of information"*.

Since `3` seems to be the most efficient one, let's find out what we can accomplish with the same 40 *"units of information"* but now in base-3.

First, how many trigits (base-3-digits) can we get with 40 *"units of information"*?.\
`40 / 3 = 13.333`, that means we can fully represent `13` trigits using less than `40` *"units of information"*, `39` to be exact.

> Fun fact: To use exactly 40 *"units of information"* we could use a number that is a frankenstein mix of base-2 and base-3, specifically, `12` trigits and `2` bits. But there's no need to complicate things, let's stick to `13` trigits.

Let's see how many combinations we get with *13 trigits*, or in other words, what's the maximum number we can describe using *13 trigits*?, if we get more than what we get with *20 bits*, then base-3 is more efficient, and so is using sets of 3 elements to maximize the *cartesian product*.

```python
>>> 3**13
1594323
>>> 2**20
1048576
```

Yayy!, using base-3 we got ~50% more combinations, that means, we can represent more numbers, besides the fact that we have a tiny bit less *"units of information"* than base-2, in fact, here's the difference

```python
>>> 3*13
39
>>> 2*20
40
```

## Conclusion

So folks, if you want to maximize the combinations of a *cartesian product*, arrange your items in groups of 3.\
Or conversely, if you want to minimize the number of combinations, stay away from groups of 3.

---

*Weeell*, it turns out 3 is not really the most optimal number, but it's close enough, it's still the king among integers, and of many practical applications.\
But the *king of kings* is in fact `e`, the base of the natural logarithm.\
And don't ask me how a base-e number system would even look like, nor how would you even name the ... *eits* ?. [You can read more about it here](https://math.stackexchange.com/questions/446664/what-is-the-most-efficient-numerical-base-system)

---

BTW *"Entropy"* may be a related concept to this. I've seen people [measuring entropy in bits, in this fascinating take of Death Note's Light Yagami's anonimity](https://gwern.net/death-note-anonymity)

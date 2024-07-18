---
tags: english, math
date: 2024-07-18
---

# Maximizing the *cartesian product* of `n` elements and how it relates to number bases

I was helping a friend in finding all possible combinations of schedules for a given set of courses, and it varied wildly the number of schedules each course had, most had 2 or 3, but other had more than 15 schedules, and when selecting the larger ones, the number of possible combinations was in the order of 10s of millions, and it was taking a looong time to compute.

## A Ridiculous Question

So then, for fun, I started to think that those were ~15 schedules in each of the 7 courses, which is roughly `15*7 = 105` schedules in total. So I thought, given a fixed number of schedules, How many courses should I distribute those `105` schedules so that it maximizes the number of possible combinations?

> Just to be clear, changing schedules from one course to another does not make sense at all. This has become a purely algorithmic / mathematical question.

## Hypothesis

I have thought in the past about common cases of permutations and combinations, like for example 10 coin flips, the result that has more combinations is 5 heads and 5 tails, hence the more likely result. So I thought *"Hmm!, this looks familiar, I bet the optimal way is to distribute things evenly"*, so my first guess was to distribute schedules in a way that the number of courses were the same as the average number of schedules in the courses, ... roughly.

But that's just a wild guess!, I want the truth!.

## Testing

So naturally, I started testing my hypothesis. To make it simple, I started with `10` items. Let's use python.

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

*Uh oh!, my guess is not doing well*. The winner is now 7 groups of ~2.833 items, both numbers are now very different, and the number of items is lower than before, even though we have increased the amount of items.

But *Hang on!*, the groups of 4 and 2 give the same combinations in both cases, is there a connection here?.\
Yes there is!, we can replace any `4` with `2*2`, because they are equivalent at calculating combinations *`4 = 2*2`* and preserving the number of items *`4 = 2+2`*.

Ok, so `3` seems to be the sweet spot, but I found it strange I've never come across this fact.

## What does this have to do with number bases?

And then I realized that this calculation is equivalent to calculating combinations in number bases. Let me explain:

- the **base** is analogous to the **average number of items in a group**
- the **number of digits** is analogous to the **number of groups**
- And the **total number of items** is analogous to __________ I have no idea, but I am going to call it *"units of information"*. **Edit**: the technical term seems to be [*"radix economy"*](https://en.wikipedia.org/wiki/Non-integer_base_of_numeration#:~:text=radix%20economy) (which is the `base number * number of digits`)

For example, How many ~~items~~ *"units of information"* do we need in base 2 to represent the number `654987`?.\
But first, What do I mean by *"units of information"* exactly?, I mean something like the amount of symbols used, ... *What???*.\
Yes, base-2 has 2 possibilities, `1` or `0` in each ~~digit~~ bit, so the *"units of information"* in `n` bits is `2*n`, and that's the amount of symbols used to represent a number.\
I risked violating nomenclature there, and get some math guys angry, but I hope you got the idea.

Ok, back to the question, to calculate the *"units of information"* we are missing the number of bits needed to represent `654987`. Let's hunt it!

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

So we need `20` bits, and the number of *"units of information"* is `20*2 = 40`.

Since 3 seems to be the most efficient one, let's find out what we can accomplish with 40 *"units of information"*.

First, how many trigits (base-3-digits) can we get with 40 *"units of information"*?.\
`40 / 3 = 13.333`, that means we can fully represent `13` trigits using less than `40` *"units of information"*.

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

So folks, if you want to maximize the combinations of a *cartesian product*, arrange your items in groups of 3.

*Weeell*, it turns out 3 is not really the most optimal number, but it's close enough, it's still the king among integers, and of many practical applications.\
But the *king of kings* is in fact `e`, the base of the natural logarithm.\
And don't ask me how a base-e number system would even look like, nor how would you even name the ... *eits* ?. [You can read more about it here](https://math.stackexchange.com/questions/446664/what-is-the-most-efficient-numerical-base-system)

---

BTW *"Entropy"* may be a related concept to this. I've seen people [measuring entropy in bits, in this fascinating take of Death Note's Light Yagami's anonimity](https://gwern.net/death-note-anonymity)

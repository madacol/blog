---
tags: english, math
date: 2024-07-18
---

# Maximizing combinations for `n` elements

I was helping someone finding all possible combinations of valid schedules for a given set of courses, and it varied wildly the number of schedules each course had, most had 2 or 3, but other had more than 15 schedules, and when selecting the larger ones, the number of possible combinations was in the order of 10s of millions, and it was taking a looong time to compute.

So then for fun I started to think, those were ~15 schedules distributed among 7 courses, which is roughly `15*7 = 105` schedules. So I thought, given a fixed number of schedules, how could I arrange them in courses in a way that would maximize the number of possible combinations?

I have thought in the past about common cases of permutations and combinations, like for example 10 coin flips, the result that has more combinations is 5 heads and 5 tails, hence the more likely result. So I thought *"Hmm!, this looks similar, I bet the optimal way is somewhere in the middle"*, and my first guess was to distribute the schedules in a way that the number of courses was the same as the number of schedules (well!, roughly the same), so essentially arrange them as close as possible to a square-matrix-like shape.

But that's just a wild guess!, I want the truth!.

So naturally, I started testing my hipotesis in a calculator. To make it simple, I started with `10` items, and test how many groups should I divide them into to maximize the number of combinations. Let's use python to do the tests.

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

So `3*3*4` is the winner, 3 groups of ~3.333 items, my guess seems to be doing well, but let's test it with more items, let's try `20` items.

```python
>>> 5*5*5*5
625
>>> 4*4*4*4*4
1024
>>> 3*3*3*3*3*3*2
1458
```

*Uh oh!, my guess is not doing well*. The winner is now 7 groups of ~2.833 items, the number of items is even lower than before, even though we have increased the amount of items. Let's see the result of the group of ~2 items

```python
>>> 2*2*2*2*2*2*2*2*2*2
1024
```

*Hang on!*, the groups of 4 and 2 give the same combinations in both cases. And of course it makes sense, I can replace any `4` with `2*2`, because they are equivalent at calculating combinations *`4 = 2*2`* and preserving the number of items *`4 = 2+2`*.


So `3` seems to be the sweet spot, but I found it strange I've never come across this fact. And then I realized that this calculation is equivalent to calculating the combinations in other number bases.

For example, How many ~~items~~ *"pieces of information"* do you need in base 2 to represent the number `654987`?. Ok, but what do I mean by *"pieces of information"*?. In the previous example, I meant the number of items, but in this case I mean something like the amount of symbols used. *What???*. I mean, base-2 has 2 possibilities, `1` or `0` in each ~~digit~~ bit, so the amount of *"pieces of information"* in `n` bits is `2*n`, and that's the amount of symbols used to represent a number. I am sure I'm violating nomenclature here, and got some mathematicians angry, but I hope you get the idea. 

Ok, so we are missing the number of bits needed to represent `654987`. Let's hunt it!

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

*Yeah I know, I could've just used the logarithm*

```python
>>> math.log(654987, 2)
19.321106747160712
```

So we need `20` bits, and the number of *"pieces of information"* is `20*2 = 40`.

Since we now know that 3 is the most efficient one, let's find out what we can accomplish with 40 *"pieces of information"* (whatever that means!).

First, how many trigits (base-3-digits) can we get with 40 *"pieces of information"*?. `40 / 3 = 13.333`, that means we can fully represent `13` trigits using less than `40` *"pieces of information"*. Let's see how many combinations we get with `13` trigits, if we get more than 20 bits, we can call it a day.

```python
>>> 3**13
1594323
>>> 2**20
1048576
>>> 3*13
39
>>> 2*20
40
```

Yayy!, using base-3 we got ~50% more combinations (we can represent more numbers) besides the fact that we have a tiny bit less *"pieces of information"* than base-2.

So folks, if you want to maximize entropy, arrange your items in groups of 3.

*Weeell*, it turns out 3 is not really the optimal number, but it's close enough, it's still the king of integers, so it's still the best for many practical applications, but the *king of kings* is in fact `e`, the base of the natural logarithm.\
And don't ask me how a base-e number system would even look like, nor how would you even name the ... *eits* ?. [You can read more about it here](https://math.stackexchange.com/questions/446664/what-is-the-most-efficient-numerical-base-system)

---

BTW *"Entropy"* is a highly related concept to this, maybe it is how experts call what I've been calling *"pieces of information"*. I've seen people [measuring entropy in bits, in this fascinating take of Death Note's Light Yagami's anonimity](https://gwern.net/death-note-anonymity), probably for simplicity since we use base-2 everywhere. But base-e is the GOAT

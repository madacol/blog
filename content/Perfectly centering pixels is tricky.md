---
title: Perfectly centering pixels is tricky
tags: knowledge, frontend, english
date: 2020-08-04
---

To perfectly center a container (like a `<div>`) inside another container, both containers' sizes must have the same parity, in other words, both sizes must be either even or odd, in the direction of centering.

Same thing happens if many containers are nested, and each of them need to be centered across its parent, they all need to be even or odd.

Font makes things trickier. Let's suppose you want to center vertically a text inside an even container, and you may think that choosing an even `font-size` will do the trick, but if you choose a size like `14px` and a `line height` different than `1` or `2` (both options are unpleasant in most cases), then text's effective height will be odd, and text `height` parity will mismatch with its parent and will be impossible to center.

## What led to learning this

Podcast: [Full Stack Radio: 135: Lessons Learned Building Tailwind UI](https://fullstackradio.com/episodes/135-e8c69ea6)

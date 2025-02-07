---
tags: english, tutorial, math
date: 2025-02-07
---

# Running Lean's Natural Number Game (nng4) locally in Linux

## TL;DR

They already have instructions here: <https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md#manual-installation>

But instead of installing the template game `GameSkeleton`, you need to install the game itself `nng4` from this repository: <https://github.com/leanprover-community/nng4>

## Pre-requirements

- Lean 4
- Node.js (version? 🤷. I had success with v18)
- git

We are going to need the commands:

- `lake` (from Lean)
- `npm` (from Node.js)
- `git`

So make sure they are installed and in your path.

> Hint: In Linux `lake` is installed in `~/.elan/bin`

## Install the game

### Install Natural Number Game (nng4)

```bash
git clone https://github.com/leanprover-community/nng4.git
cd nng4
lake update -R
lake build
```

### Install Lean4 Game Engine

```bash
git clone https://github.com/leanprover-community/lean4game.git
cd lean4game
npm install
```

## Run the game

```bash
# make sure you are in the lean4game folder
npm start
```

## Open the game in the browser

Open <http://localhost:3000/#/g/local/NNG4> in your browser.

## Bonus: Bookmarklet to export/import your progress

[Bookmarklet to export/import your progress](javascript:(()=>{javascript%3A(function()%7B%0A%20const%20progress%20%3D%20localStorage.getItem('game_progress')%3B%0A%20%20%20%20if(prompt('Current%20save%20(copy%20it%20or%20paste%20a%20new%20one)%3A'%2C%20progress))%20%7B%0A%20%20%20%20%20%20%20%20try%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20JSON.parse(newProgress)%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20localStorage.setItem('game_progress'%2C%20newProgress)%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20alert('Imported!')%3B%0A%20%20%20%20%20%20%20%20%7D%20catch(e)%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20alert('Invalid%20JSON!')%3B%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%7D)()%3B})())


```javascript
javascript:(function(){
    const progress = localStorage.getItem('game_progress');
    if(prompt('Current save (copy it or paste a new one):', progress)) {
        try {
            JSON.parse(newProgress);
            localStorage.setItem('game_progress', newProgress);
            alert('Imported!');
        } catch(e) {
            alert('Invalid JSON!');
        }
    }
})();
```

---
tags: english, tutorial, math
date: 2025-02-07
---

# Running Lean's Natural Number Game (nng4) locally in Linux

## TL;DR

Official instructions to install the engine (but not the game) are available here: <https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md#manual-installation>

However, to play the Natural Number Game, instead of installing the template game `GameSkeleton`, you'll need to install `nng4` from: <https://github.com/leanprover-community/nng4>

---

## Prerequisites

- Lean 4
- Node.js (version? 🤷. I had success with v18)
- git

The following commands must be available in your PATH:

- `lake` (Lean's package manager)
- `npm` (Node.js package manager)
- `git`

> Note: On Linux, the `lake` command is typically installed in `~/.elan/bin`

## Installation

**Important:** Both the game and engine **must** be installed in the same parent directory.

### Install Natural Number Game (nng4)

```bash
git clone https://github.com/leanprover-community/nng4.git
cd nng4
lake update -R
lake build
cd .. # Go back to the parent directory
```

### Install Lean4 Game Engine

```bash
git clone https://github.com/leanprover-community/lean4game.git
cd lean4game
npm install
```

## Running the Engine

```bash
# Make sure you are in the lean4game directory
npm start
```

## Accessing game

The URL should be: <http://localhost:3000/#/g/local/nng4>

All local games can be accessed by its folder name in the URL: <http://localhost:3000/#/g/local/{game_folder}>

Since the *Natural Number Game* is installed in the `nng4` directory (which **must** be side-by-side to the `lean4game` directory), the URL is: <http://localhost:3000/#/g/local/nng4>

## Bonus: Bookmarklet to Export/Import Your Progress

[Bookmarklet](javascript:(()=>{const%20progress%20%3D%20localStorage.getItem('game_progress')%3B%0Aconst%20newProgress%20%3D%20prompt('Current%20save%20(copy%20it%20or%20paste%20a%20new%20one)%3A'%2C%20progress)%3B%0Aif(newProgress)%20%7B%0A%20%20%20%20try%20%7B%0A%20%20%20%20%20%20%20%20JSON.parse(newProgress)%3B%0A%20%20%20%20%20%20%20%20localStorage.setItem('game_progress'%2C%20newProgress)%3B%0A%20%20%20%20%20%20%20%20alert('Imported!')%3B%0A%20%20%20%20%7D%20catch(e)%20%7B%0A%20%20%20%20%20%20%20%20alert('Invalid%20JSON!')%3B%0A%20%20%20%20%7D%0A%7D})())

or execute this JavaScript code in the browser's console:

```javascript
{
    const progress = localStorage.getItem('game_progress');
    const newProgress = prompt('Current save (copy it or paste a new one):', progress);
    if(newProgress) {
        try {
            JSON.parse(newProgress);
            localStorage.setItem('game_progress', newProgress);
            alert('Imported!');
        } catch(e) {
            alert('Invalid JSON!');
        }
    }
}
```

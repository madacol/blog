# Shortcuts

*For Ubuntu's default keybinding settings (i.e Emacs keybindings)*

## Insert previous arguments
  - <kbd>Alt</kbd>+<kbd>.</kbd>: insert last argument from last command.
  - <kbd>Alt</kbd>+<kbd>number</kbd>+<kbd>.</kbd>: insert #nth last argument from last command.
  - <kbd>Alt</kbd>+<kbd>-</kbd> , <kbd>number</kbd> , <kbd>Alt</kbd>+<kbd>.</kbd>, **zsh:** <kbd>Alt</kbd>+<kbd>-</kbd>+<kbd>#</kbd>+<kbd>.</kbd>: insert #nth first argument from last command.

*In Linux you can repeat commands to go back in history*

### Example:

Last command is:

    mv foo bar

  - <kbd>Alt</kbd>+<kbd>0</kbd>+<kbd>.</kbd>: insert first argument of last command = `mv`
  - <kbd>Alt</kbd>+<kbd>2</kbd>+<kbd>.</kbd>: insert last 2nd argument of last command = `foo`
  - <kbd>up</kbd> , <kbd>Ctrl</kbd>+<kbd>w</kbd>: last command without the last word = `mv foo`


## Cut/Paste commands
*(relative to cursor's position)*
  - <kbd>Ctrl</kbd>+<kbd>w</kbd>: cuts last word
  - <kbd>Alt</kbd>+<kbd>d</kbd>: cuts next word
  - <kbd>Ctrl</kbd>+<kbd>k</kbd>: cuts everything after
  - <kbd>Ctrl</kbd>+<kbd>u</kbd>, **zsh:** <kbd>Alt</kbd>+<kbd>w</kbd>: cuts everything before
  - **zsh:** <kbd>Ctrl</kbd>+<kbd>u</kbd>: cuts the entire command *(In bash you can combine <kbd>Ctrl</kbd>+<kbd>u</kbd> , <kbd>Ctrl</kbd>+<kbd>k</kbd>)*
  - <kbd>Ctrl</kbd>+<kbd>y</kbd>: paste characters previously cut with any **Cut command**. *In bash you can chain **cut commands**, and <kbd>Ctrl</kbd>+<kbd>y</kbd> will paste them all.*


## Move cursor
  - <kbd>Ctrl</kbd>+<kbd>left</kbd>: move to last word
  - <kbd>Ctrl</kbd>+<kbd>right</kbd>: move to next word
  - <kbd>home</kbd> or <kbd>Ctrl</kbd>+<kbd>a</kbd>: move to start of command
  - <kbd>end</kbd> or <kbd>Ctrl</kbd>+<kbd>e</kbd>: move to end of command


## Other
  - <kbd>Ctrl</kbd>+<kbd>_</kbd>: undo last edit *(very useful when exceeding <kbd>Ctrl</kbd>+<kbd>w</kbd>)*

## To see all shortcuts available
  - **bash:** `bind -lp`
  - **zsh:** `bindkey -L`

# Custom shortcuts
## Iterate through the arguments in a previous command
*only works in zsh, and probably only Linux*

run or add this to your `~/.zshrc`

    autoload -Uz copy-earlier-word
    zle -N copy-earlier-word
    bindkey "^[:" copy-earlier-word

Now use <kbd>Alt</kbd>+<kbd>.</kbd> to go as back as you want, then use <kbd>Alt</kbd>+<kbd>:</kbd> to iterate through the arguments

### Example:
Last command is

    echo 1 2 3 4 5

- <kbd>Alt</kbd>+<kbd>.</kbd>: `5`
- <kbd>Alt</kbd>+<kbd>.</kbd>+<kbd>:</kbd>: `4`
- <kbd>Alt</kbd>+<kbd>.</kbd>+<kbd>:</kbd>+<kbd>:</kbd>: `3`
- <kbd>Alt</kbd>+<kbd>.</kbd>+<kbd>:</kbd>+<kbd>:</kbd>+<kbd>:</kbd>: `2`
- <kbd>Alt</kbd>+<kbd>.</kbd>+<kbd>:</kbd>+<kbd>:</kbd>+<kbd>:</kbd>+<kbd>:</kbd>: `1`
- <kbd>Alt</kbd>+<kbd>.</kbd>+<kbd>:</kbd>+<kbd>:</kbd>+<kbd>:</kbd>+<kbd>:</kbd>+<kbd>:</kbd>: `echo`

source: https://stackoverflow.com/a/34861762/3163120


# Other examples

## Common usecases
Let's consider the last command to be:

    mv foo bar

<kbd>up</kbd> , <kbd>Ctrl</kbd>+<kbd>w</kbd>: last command without the last word = `mv foo`

<kbd>Alt</kbd>+<kbd>0</kbd>+<kbd>.</kbd>: first argument of last command = `mv`

# Limitations
 "words" only includes `a-zA-Z` characters, so any symbol character will stop word-shortcuts.

So if last argument was a url and you want to erase it with <kbd>Ctrl</kbd>+<kbd>w</kbd> it will be a pain.

E.g: `curl -I --header "Connection: Keep-Alive" https://stackoverflow.com/questions/38176514/re-run-previous-command-with-different-arguments`

To erase that **url** using <kbd>Ctrl</kbd>+<kbd>w</kbd>, you'd have to repeat it 12 times.


---


It would be great to have similar shortcuts that only stops at the **space character**
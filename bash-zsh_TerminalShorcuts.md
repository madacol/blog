Let's consider the last command to be:

    mv foo bar

<kbd>up</kbd> , <kbd>Ctrl</kbd>+<kbd>w</kbd>: last command without the last word = `mv foo`

<kbd>Alt</kbd>+<kbd>0</kbd>+<kbd>.</kbd>: first argument of last command = `mv`

## Some useful shortcuts:

 - **Select previous arguments**
   - <kbd>Alt</kbd>+<kbd>.</kbd>: insert last argument from last command.
   - <kbd>Alt</kbd>+<kbd>number</kbd>+<kbd>.</kbd>: insert #nth last argument from last command.
   - <kbd>Alt</kbd>+<kbd>-</kbd> , <kbd>number</kbd> , <kbd>Alt</kbd>+<kbd>.</kbd>, **zsh:** <kbd>Alt</kbd>+<kbd>-</kbd>+<kbd>#</kbd>+<kbd>.</kbd>: insert #nth first argument from last command.
   
   *In Linux you can repeat commands to go back in history*


 - **Cut commands** (relative to cursor's position)
   - <kbd>Ctrl</kbd>+<kbd>w</kbd>: cuts last word
   - <kbd>Alt</kbd>+<kbd>d</kbd>: cuts next word
   - <kbd>Ctrl</kbd>+<kbd>k</kbd>: cuts everything after
   - <kbd>Ctrl</kbd>+<kbd>u</kbd>, **zsh:** <kbd>Alt</kbd>+<kbd>w</kbd>: cuts everything before
   - **zsh:** <kbd>Ctrl</kbd>+<kbd>u</kbd>: cuts the entire command *(In bash you can combine <kbd>Ctrl</kbd>+<kbd>u</kbd> , <kbd>Ctrl</kbd>+<kbd>k</kbd>)*
   - <kbd>Ctrl</kbd>+<kbd>y</kbd>: paste characters previously cut with any **Cut command**. *In bash you can chain **cut commands**, and <kbd>Ctrl</kbd>+<kbd>y</kbd> will paste them all.*
 - <kbd>Ctrl</kbd>+<kbd>_</kbd>: undo last edit *(very useful when exceeding <kbd>Ctrl</kbd>+<kbd>w</kbd>)*
 - <kbd>Ctrl</kbd>+<kbd>left</kbd>: move to last word
 - <kbd>Ctrl</kbd>+<kbd>right</kbd>: move to next word
 - <kbd>home</kbd> or <kbd>Ctrl</kbd>+<kbd>a</kbd>: move to start of command
 - <kbd>end</kbd> or <kbd>Ctrl</kbd>+<kbd>e</kbd>: move to end of command

### To see all shortcuts available
- **bash:** `bind -lp`
- **zsh:** `bindkey -L`

## Unfortunately there are some limitations
 "words" only includes `a-zA-Z` characters, so any symbol character will stop word-shortcuts.

So if last argument was a url and you want to erase it with <kbd>Ctrl</kbd>+<kbd>w</kbd> it will be a pain.

E.g: `curl -I --header "Connection: Keep-Alive" https://stackoverflow.com/questions/38176514/re-run-previous-command-with-different-arguments`

To erase that **url** using <kbd>Ctrl</kbd>+<kbd>w</kbd>, you'd have to repeat it 12 times.


---


It would be great to have similar shortcuts that only stops at the **space character**
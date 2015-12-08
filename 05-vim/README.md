# vim

If you haven't done so already, please clone the git repo and `cd` into the `05-vim` directory.

## History

In the beginning was the Word.

Then, in 1969, Ken Thompson wrote `ed`.

In 1976, George Coulouris improved `ed` to create `em`. This inspired Bill Joy and Chuck Haley to write `en`, then `ex`. Bill Joy then added a visual mode to `ex`, which became `vi`.

Then it all went dark for 15 years, until 1991 when Bram Moolenaar wrote `Vim`. The name was originally a contraction meaning "Vi IMitation", but was retrospectively change to mean "Vi IMproved".

## Insert, normal and visual modes

Vim has three editing modes. You are in exactly one mode at any one time, and you switch between modes to perform different actions.

* In `insert` mode, all you can do is write text. You cannot copy, navigate, select text, or do anything else.
* In `normal` mode, you can navigate around the file, save the file, open new files, delete text, etc.
* In `visual` mode, you can select text in order to copy or delete it.

You switch between modes by pressing certain keys:

* To go from **any** mode to **normal** mode, press `Ctrl-c`. (You can also press `Esc`, but this is not recommended because it takes your fingers away from the home row on the keyboard.)
* To go from **normal** mode to **visual** mode, press `v` or `V`. (`v` will select one character at a time, while `V` will select whole lines at a time.)

### Entering insert mode

There are a few ways to enter insert mode, depending on what you want to do. Assuming you are currently in **normal** mode:

* Press `i` (for "insert") to start typing exactly where the cursor is
* Press `a` (for "append") to start typing exactly one character after where the cursor is
* Press `o` to insert a new line and start typing
* Press `I` to jump to the start of the current line and start typing
* Press `c$` to delete from the cursor to the end of the line and start typing
* ... and many other ways

## Moving the cursor around

These key bindings will be familiar if you have used `less`.

* The right-hand home keys are used for the most common navigation: `j` is down, `k` is up, `h` is left, `l` is right. (Once you have a muscle memory for these, they seem like the most natural thing in the world.)
* `^` jumps to the start of the current line, `$` jumps to the end.
* `b` jumps to the start of the current word, `w` jumps to the next word.
* `{` and `}` jump to the start and end of the current paragraph.
* `%` jumps to the start or end of a pair of parentheses.
* `Ctrl-f` and `Ctrl-b` jump forward or backward by one page.
* `gg` jumps to the top of the file, `G` jumps to the end.

## Searching and replacement

You can search for the text "foo" using `/foo`, or `?foo` to search backwards. You can also use regular expressions. 

After searching, press `n` or `p` to jump to the next or previous match.

To search for the word under the cursor, press `*`.

To replace "foo" with "bar" everywhere in the file, press `:%s/foo/bar/g`. Breaking down this cryptic string:

* `:` is the way to start writing a Vim command
* `%` defines the range on which to apply the command, in this case the whole file. If you don't specify a range, the command will only be applied to the current line.
* `s/pattern/replacement/` is the syntax for search and replace
* `g` means replace all occurrences on a given line, not just the first one

## Yanking, deleting and pasting

After selecting some text in visual mode, you can press `y` to "yank" it (i.e. copy it) into the so-called "register" (you can think of this as like the clipboard).

Once text is in the register, you can "paste" it somewhere else by typing `p`.

Deleting text with `d` will also leave it in the register.

You can also yank and delete text without going into visual mode. e.g.

* `yy` will yank the current line
* `dw` will delete up to the start of the next word
* `y$` will yank from the cursor to the end of the line
* `10dd` will delete the next 10 lines

## Undo and redo

You can undo the last action using `u`, and then redo it using `Ctrl-r`. There is an undo history so you can undo multiple times.

## Saving and quitting

Press `:w` to save the file, `:q` to quit. To save and quit in one command, type `:wq` or `ZZ`.

## Plugins

The real power of Vim lies in extending its functionality using plugins.

I use Pathogen as a plugin manager, but apparently Vundle is what the cool kids use these days.

## Exercise

Open `christmas.txt` and write a Christmas story!

## Configuring Vim

You can configure Vim using the file `~/.vimrc`. I've put a copy of my `.vimrc` into this folder for reference.

## Further reading

For a glimpse of some other powerful Vim features, and an explanation of how the key bindings are not random and there is a logic behind them, see this excellent StackOverflow answer: http://stackoverflow.com/a/1220118/110856

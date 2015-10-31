# Text processing

If you haven't done so already, please clone the git repo and `cd` into the `02-text-processing` directory.

## Writing text to a file

There are a few simple ways to write text to a file.

* `echo`

    ```
    $ echo "hello world" > hello.txt  # If the file doesn't exist, create it. If it does, overwrite its contents.

    $ echo "hello world" >> hello.txt  # If the file doesn't exist, create it. If it does, append to the end of it.
    ```

* `cat`

    You can write multiple lines to a file, you can use `cat`. Just write the file's contents on `stdin`. Press `Ctrl-D` when you are done.

    ```
    $ cat > hello.txt hello.txt
    Hello
    This is a file
    with a few
    lines
    ```

## Inspecting a text file

You can also use `cat` to print out a file's contents:

```
$ cat hello.txt
Hello
This is a file
with a few
lines
```

### less

If the file is very long, you can use `less` to view it with a pager.

```
$ less README.md
```

Inside `less`, you can scroll up and down the file, and perform searches.

Navigation:

* `j`, or `<enter>` moves down a line
* `k` moves up a line
* `G` jumps to the bottom of the file
* `gg` takes you back to the top of the file
* `Ctrl-F` or `<space>` moves down one page
* `Ctrl-B` moves up one page

Searching:

* `/` lets you search for a string. It searches forward from the current position in the file. e.g. `/hello<enter>`
* `?` searches backwards from the current position in the file. e.g. `?hello<enter>`
* `n` jumps to the next match

To exit the program, press `q`.

Exercise: Run `less README.md` and familiarise yourself with the keys for navigation and searching. Try searching for "hello".

### more

Don't use `more`. It's an older, worse version of `less`.

### head and tail

You can look at the first few or last few lines of a file using `head` or `tail`.

```
$ head my-long-file.txt  # Prints the first 10 lines of the file

$ head -n 50 my-long-file.txt  # Prints the first 50 lines

$ my-noisy-command | head  # Prints the first 10 lines of the command's stdout
```

## grep

`grep` is a very versatile tool for searching for text in one or more files. You can search for simple strings, or use regular expressions for more powerful searching. It's useful for extracting only the information we are interested in from a large log file.

By default, `grep` will print out all lines that match the search expression.

Command: `$ grep "hello" README.md`

Output:

```
    $ echo "hello world" > hello.txt  # If the file doesn't exist, create it. If it does, overwrite its contents.
    $ echo "hello world" >> hello.txt  # If the file doesn't exist, create it. If it does, append to the end of it.
    $ cat > hello.txt hello.txt
$ cat hello.txt
* `/` lets you search for a string. It searches forward from the current position in the file. e.g. `/hello<enter>`
* `?` searches backwards from the current position in the file. e.g. `?hello<enter>`
```

Here's an example of using a regular expression to find all lines containing a word that starts with "c" and ends with "e".

Command: `$ grep "c\w*e " README.md`

Output:

```
If you haven't done so already, please clone the git repo and `cd` into the `02-text-processing` directory.
$ echo "hello world" > hello.txt  # If the file doesn't exist, create it. If it does, overwrite its contents.
$ echo "hello world" >> hello.txt  # If the file doesn't exist, create it. If it does, append to the end of it.
```

You can run `grep` on multiple files, e.g. `$ grep "hello" *.txt`. Or on a whole directory: `$ grep -r "hello" /tmp`.

You can also pipe input into it from another command, if you want to filter out noisy output: `$ my-command | grep WARNING`.

### Variants of grep

* `fgrep` or `grep -F` ("fast grep") is a stripped-down version of `grep` that does not support regular expressions. It can search for literal strings in large files much faster than normal grep.
* `egrep` or `grep -E` ("extended grep") provides support for "extended" regular expressions. For example, `egrep` supports the "+" quantifier (meaning "one or more") in regular expressions.
* `zgrep` or `grep -Z` allows you to run grep on GZip-compressed files. It automatically decompresses the file on the fly.
* `zfgrep` and `zegrep` are combinations of the above.

### Useful flags

* `-B 5` (B for "before") prints the 5 lines before each matching line, as well as the matching line itself
* `-A 5` (A for "after") prints the 5 lines after each matching line, as well as the matching line itself
* `-C 5` (C for "context") prints the 5 lines before and after each matching line, as well as the matching line itself
* `--color` highlights the part of the line that matched
* `-o` prints out only the part of the line that matched
* `-v` prints out all lines that DO NOT match the search expression

Exercises: 

1. Use grep to find all lines containing the phrase "Elements generation" in the file `data/concierge.log`.
2. Now find all lines containing that phrase in both `concierge.log` and `concierge.log.2015-10-30`.
3. Out of all of those matching lines, find the ones that contain the phrase "wildly wrong". Hint: you may want to chain multiple grep command together using `|`.
4. For each of those matching lines, print out only the "ID = [...]" part. Hint: You will need to use a regex for this one.

## sed

TODO

TODO Exercise: updating the Cassandra host in kong.yml

## awk

TODO

TODO Exercises: print URLs in spray.log, calculate average time taken by an Allocation Failure in gc.log.

## sort and uniq

TODO

## Other useful text processing commands

There are plenty more commands available for manipulating text. Some useful ones include `cut`, `rev`, `column`, `join` and `comm`. Check their man pages to see how they work.

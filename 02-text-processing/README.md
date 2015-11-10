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

    You can write multiple lines to a file using `cat`. Just write the file's contents on `stdin`. Press `Ctrl-D` when you are done.

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
* `Shift-n` jumps to the previous match

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

$ my-noisy-command | tail  # Prints the last 10 lines of the command's stdout
```

### tail -f

You can use `tail -f` (f for "follow") to print out a file or stream that is still being written to. As soon as a new line is added to the file, it will be printed to the screen.

```
$ tail -f web-server-requests.log  # Print out the requests arriving at your web server as they happen
```

## grep

`grep` is a very versatile tool for searching for text in one or more files. You can search for simple strings, or use regular expressions for more powerful searching. It's useful for extracting only the information we are interested in from a large log file. `grep` is short for global regular expression print (`g/re/p`).

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
* `-i` (i for "ignore case") prints out all lines that match, ignoring case distinctions

### grep and tail -f

`grep` is often combined with `tail -f` to follow an application's log in real-time whilst filtering out anything you don't care about:

```
$ tail -f my-application.log | grep ERROR  # Follow the log in real-time but only show lines that contain the word "ERROR"
```

### Exercises

1. Use grep to find all lines containing the phrase "Elements generation" in the file `data/concierge.log`.
2. Now find all lines containing that phrase in both `concierge.log` and `concierge.log.2015-10-30.gz`.
3. Out of all of those matching lines, find the ones that contain the phrase "wildly wrong". Hint: you may want to chain multiple grep command together using `|`.
4. For each of those matching lines, print out only the "ID = [...]" part. Hint: You will need to use a regex for this one.

## sed

`sed` is also a very versatile tool, but its most common usage is to find and replace strings in a text file or stream. You define the replacement you want to make with an expression of the form:

```
s/pattern/replacement/
```

For example,

```
$ echo hello world | sed s/world/moon/
hello moon
```

In this simple example we searched for the literal string "world" and replaced it with the literal string "moon". Not very exciting. But the real power of `sed` is in the use of regular expressions.

```
$ echo The date is 11-07-2015 | sed -E 's/([0-9]{2})-([0-9]{2})-([0-9]{4})/\2-\1-\3/'
The date is 07-11-2015
```

Here we have used a regular expression to match the pattern "2 digits, dash, 2 digits, dash, 4 digits" and capture each group of digits, then referenced those captured groups in our replacement string.

Note: By default `sed` will only replace the first match it finds on each line. To replace all matches, add a `g` (for "global") to your expression: `s/world/moon/g`.

### Working with files

You can use sed by piping other commands to it, as shown above, or by giving it the name of a file to use as input:

```
$ echo hello world > input.txt

$ sed s/world/moon/ input.txt
hello moon
```

You can tell `sed` to update the input file in-place, overwriting the contents of the file:

```
$ sed -i ".orig" s/world/moon/ input.txt  # Update input.txt in-place, saving the original file contents as input.txt.orig

$ sed -i "" s/world/moon/ input.txt  # Update input.txt in-place, with no backup file
```

Exercises (based on something I actually needed to do the other day):

1. Use sed to replace the string "localhost:9042" with "1.2.3.4:9042" in the file `data/kong.yml`. (Don't update the file in-place.)

2. Now use sed with a regular expression to replace the pattern `localhost:<port number>` with `1.2.3.4:<port number>`.

## awk

`awk` is more like a mini programming language than just a command. You use it by passing it a program made up of one or more commands of the form `pattern { action }`:

```
$ awk '{ print $1 }' input.txt  # Print out the first column of every line in input.txt

$ awk '/hello/ { print $0 }' input.txt  # Print out any line that contains the word "hello"

$ awk '$9 == "200" { print "OK: " $7 }' spray.log  # Print "OK: <url>" for all 200 responses in the web server log

$ awk '$9 == "200" { print "OK: " $7 } \
       $9 == "404" { print "Not found: " $7 }' spray.log  # Print "OK: <url>" for all 200 responses, "Not found: <url>" for all 404s

$ awk '$9 == "200" { ok++ } \
       $9 == "404" { notfound++ } \
       END         { print "OK: " ok ", Not found: " notfound }' spray.log
OK: 500, Not found: 2
```

### Exercises (hard!)

1. Use awk to print the number of times each URL was requested in spray.log. The output should look something like this. Hint: you will need to use [String functions](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#String-Functions) and associative arrays.

    ```
    /uk 1
    /favicon.ico 1
    /politics/2015/oct/21/asd 2
    /manager/html 1
    /editions 340
    /search 1
    /childrens-books-site/gallery/2014/oct/19/best-culturally-diverse-picture-books-for-toddlers-and-infants 2
    / 154
    ```

2. Print the average of the GC time (column 12) of lines containing "Allocation Failure" in the `gc.log` file. The answer should be `0.0051873`.

## sort and uniq

The `sort` command, as the name suggests, sorts its input.

```
$ cat fruits.txt
banana
apple
cherry

$ sort fruits.txt
apple
banana
cherry
```

By default it sorts lexicographically, but if you have a list of numbers then you can use the `-n` flag to sort them numerically:

```
$ cat numbers.txt
15
103
3
2

$ sort numbers.txt  # sort lexicographically
103
15
2
3

$ sort -n numbers.txt  # sort numerically
2
3
15
103

$ sort -n -r numbers.txt  # reverse the sort order
103
15
3
2
```

You can also sort by a certain column:

```
$ cat orders.csv
Widgets,150
Sprockets,123
Thingies,456

$ sort -k 2 -t "," -n orders.csv  # sort numerically by the second column
Sprockets,123
Widgets,150
Thingies,456
```

### uniq

The `uniq` command finds all the distinct lines in a file. It depends on the input being sorted, so it is usually used in conjunction with the `sort` command:

```
$ cat stuff.txt
foo
bar
baz
foo
foo
baz
bar
foo
baz
wow
yeah
bar
foo
baz

$ sort stuff.txt | uniq
bar
baz
foo
wow
yeah
```

## Other useful text processing commands

There are plenty more commands available for manipulating text. Some useful ones include `cut`, `rev`, `column`, `join` and `comm`. Check their man pages to see how they work.

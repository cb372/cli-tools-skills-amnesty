# Hello world

First let's clone this repository:

```
$ git clone https://github.com/cb372/cli-tools-skills-amnesty.git
```

## Changing directory

Then change into this directory:

```
$ cd cli-tools-skills-amnesty/01-hello-world
```

`cd` is short for "Change Directory".

Now let's check where we are:

```
$ pwd
/Users/cbirchall/code/cli-tools-skills-amnesty/01-hello-world
```

`pwd` is short for "Present Working Directory". It tells you the directory that you're currently working in.

By the way, `cd -` will take you to whatever directory you were in previously, so you can use it to switch back and forth between two directories:

```
$ pwd
/Users/cbirchall/code/cli-tools-skills-amnesty/01-hello-world
$ cd -
~/code
$ cd -
~/code/cli-tools-skills-amnesty/01-hello-world
```

You can move to the parent directory using `cd ..`, or back to your home directory using just `cd`:

```
$ pwd
/Users/cbirchall/code/cli-tools-skills-amnesty/01-hello-world
$ cd ..    # goes to the parent dir
$ pwd
/Users/cbirchall/code/cli-tools-skills-amnesty
$ cd       # goes to your home dir
$ pwd
/Users/cbirchall
$ cd code/cli-tools-skills-amnesty/01-hello-world
$ pwd
/Users/cbirchall/code/cli-tools-skills-amnesty/01-hello-world
```

## Listing files

Now let's see what's in the directory, using `ls`:

```
$ ls
README.md hello.txt
```

`ls` is short for "LiSt files". Here it shows that we have 2 files in the directory.

`ls -l` shows each file on its own line, with some useful information:

```
$ ls -l
total 16
-rw-rw-rw-  1 cbirchall  staff  1325 Sep 25 18:07 README.md
-rw-rw-rw-  1 cbirchall  staff     7 Sep 25 17:59 hello.txt
```

The first line (`total 16`) shows the total size of the directory on disk (it's the number of 512-byte blocks, if you're interested).

The columns shown for each file are as follows:

1. The permissions flags (see below)
2. The number of links to the file (don't worry about this)
3. The owner of the file
4. The group that owns the file
5. The size of the file in bytes
6. The date and time of the last modification
7. The file name

Some more useful flags for `ls`:

```
$ ls -lh  # -h prints file sizes in human-readable format
total 16
-rw-rw-rw-  1 cbirchall  staff   2.0K Sep 25 18:18 README.md
-rw-rw-rw-  1 cbirchall  staff     7B Sep 25 17:59 hello.txt

$ ls -lt  # -t sorts by modification time (newest first)
total 16
-rw-rw-rw-  1 cbirchall  staff  2031 Sep 25 18:18 README.md
-rw-rw-rw-  1 cbirchall  staff     7 Sep 25 17:59 hello.txt

$ ls -ltr # -r reverses the sort order
total 16
-rw-rw-rw-  1 cbirchall  staff     7 Sep 25 17:59 hello.txt
-rw-rw-rw-  1 cbirchall  staff  2031 Sep 25 18:18 README.md

$ ls -la  # -a shows hidden and special files
total 40
drwxrwxrwx  5 cbirchall  staff    170 Sep 25 18:22 .               # this is the directory itself
drwxrwxrwx  9 cbirchall  staff    306 Sep 25 18:07 ..              # this is the parent directory
-rw-r--r--  1 cbirchall  staff  12288 Sep 25 18:23 .README.md.swp  # this is a hidden file (starts with a dot)
-rw-rw-rw-  1 cbirchall  staff   2660 Sep 25 18:22 README.md
-rw-rw-rw-  1 cbirchall  staff      7 Sep 25 17:59 hello.txt
```

Exercises:

* List the directory contents in order of increasing file size. Hint: read the manual (`man ls`)
* Now sort them by time of file creation

## File permissions

When you listed files using `ls -l`, the first showed the permissions of each file and directory. e.g. :

```
-rw-r--r--  1 cbirchall  staff  12288 Sep 25 18:23 .README.md.swp
```

Let's look at that permissions string in detail:

```
-rw-r--r--
```

The first character (`-`) is not very interesting. It just shows whether the file is a normal file (`-`) or a directory (`d`).

The remaining 9 characters should be read in groups of 3: `rw-`, `r--`, `r--`. They show the file's permissions for 

1. the file owner
2. members of the file's owner group
3. everybody else

respectively.

In each group of 3 characters, the characters represent, in order, permissions to Read, Write and eXecute. The meanings of these are different depending on whether you are talking about a normal file or a directory.

### Permissions on normal files

* `r` (or `-`) means a user can (or cannot) read or copy the file
* `w` means the user can write to the file
* `x` means the user can execute the file. This is relevant for e.g. Bash scripts.

### Permissions on directories

* `r` (or `-`) means a user can list the files in the directory
* `w` means the user can delete files from the directory or move files into it
* `x` means the user can read files inside the directory, as long as they have read permissions on those files

### Reading a line of `ls -l` output

Using the same example as before,

```
-rw-r--r--  1 cbirchall  staff  12288 Sep 25 18:23 .README.md.swp
```

We can see the following:

* It's a normal file (the first character of the permissions string is `-`)
* User `cbirchall` is the owner of the file and can read and write it but not execute it
* The file's owner group is `staff`. Members of this group can read the file but not write or execute it
* Everybody else can read the file but not write or execute it

Exercise: Run `ls -l` and check that you understand the output

## Changing a file's owner or owner group

You can use `chown` ("CHange OWNer") command to change the owner of a file. You need to be a super-user to do this:

```
$ sudo chown nobody hello.txt
```

You can use `chgrp` ("CHange GRouP") to change the owner group:

```
$ sudo chown wheel hello.txt
```

Or you can use `chown` to change both at the same time:

```
$ sudo chown nobody:wheel hello.txt
```

Exercise: Change the owner of the `README.md` file to the `nobody` user.

You can use the `chmod` command to change a file's permissions:

```
$ chmod u+x hello.txt  # Allow the file's owner to execute the file

$ chmod g-w hello.txt  # Do not allow users in the file's owner group to write to the file
```

## Creating and deleting files and directories

Let's create a directory. You can do this with the `mkdir` ("MaKe DIRectory") command.

```
$ pwd
/Users/cbirchall/code/cli-tools-skills-amnesty/01-hello-world

$ mkdir hello

$ ls -l
total 16
-rw-rw-rw-  1 cbirchall  staff  3410 Sep 25 18:33 README.md
drwxrwxrwx  2 cbirchall  staff    68 Oct 14 11:31 hello
-rw-rw-rw-  1 cbirchall  staff     7 Sep 25 17:59 hello.txt
```

Now let's try to make a deeply nested directory: `how/are/you`:

```
$ mkdir how/are/you
mkdir: how/are: No such file or directory
```

Oops, that didn't work. You can't make a directory unless its parent directory already exists. But we can tell `mkdir` to create any directories it needs along the way, using the `-p` (p for "parent") flag:

```
$ mkdir -p how/are/you
```

We can create files in a few different ways. If you want to create a completely empty file, you can use the `touch` command:

```
$ touch how/are/you/fine-thanks.txt
```

Or if you want to write some text to a file, you can do so with `echo`:

```
$ echo "It's a lovely day" > how/are/you/not-bad.txt
```

We'll discuss that little arrow in more detail below.

### Deleting files and directories

You can delete a file using the `rm` ("ReMove") command:

```
$ rm how/are/you/not-bad.txt
```

To delete a directory, you need to pass the `-r` ("recursive") flag, telling the command to delete everything inside the directory and then delete the directory itself:

```
$ rm -r how/are/you
```

Exercise: Delete the `how` and `hello` directories that you created.

## Finding files

You can use the `find` command to find files that match certain conditions.

```
# Find all files in the current directory
$ find .

# Find all files in the "hello" directory
$ find hello

# Find all files in current dir starting with "h"
$ find . -name "h*"

# Find all directories in current dir
$ find . -type d

# Find all files in current dir created in the last hour and a half
$ find . -ctime -1h30m

# Find all files in current dir created in the last hour and a half that are larger than 1 GB
$ find . -ctime -1h30m -size +1G
```

You can also tell `find` to execute some command for every file that matches, e.g.

```
$ find . -name "h*" -exec echo "Found a file called {}" \;
Found a file called ./hello
Found a file called ./hello.txt
```

Exercise: Find all files ending with ".md" in this directory and copy them (using the `cp` command) to a new file with `.foo` appended to the name. e.g. `README.md` should be copied to a new file `README.md.foo`.

## Piping and redirection

UNIX processes communicate with the world using streams. There are 3 standard streams: `stdin` (standard input), `stdout` (standard output) and `stderr` (standard error).

You can use the pipe (`|`) operator to chain two processes together. This simply links the `stdout` of the first process to the `stdin` of the second. e.g.:

```
$ echo "hello world"
hello world

$ echo "hello world" | wc -w
       2
```

The `echo` command prints "hello world" to its `stdout` stream. Using a pipe, we use that as the `stdin` for the `wc` ("Word Count") command. The `wc` command prints out the number of words in its input.

You can use `|` to chain together as many processes as you like, and it's common to build quite long chains, e.g.:

```
$ fgrep "ERROR" application.log | grep -oP 'ID = \K\w+' | sort | uniq 
```

(By the end of the next lesson, you should be able to work out what this command does!)

### Redirection

By default, the content of both `stdout` and `stderr` are printed to the console. But sometimes you don't want this. You might want to save it to a file instead, or maybe just discard it completely if it is very noisy. You can do this using redirection.

In the following examples, we reference the standard streams by number: 1 = `stdout`, 2 = `stderr`.

```
$ my-command >output.txt  # Saves stdout to a file called output.txt. stderr will still be printed to the console.

$ my-command >/dev/null  # Sends stdout to a black hole, never to be seen again. stderr will still be printed to the console.

$ my-command 2>/dev/null  # Sends stderr to a black hole, never to be seen again. stdout will still be printed to the console.

$ my-command >output.txt 2>&1 # Redirects stderr to stdout, and saves them both to a file.

$ first-command 2>/dev/null | second-command # Discards stderr, and sends stdout to the second command

$ first-command 2>&1 | second-command # Redirects stderr to stdout, and sends them both to the second command
```

If you want to both view a command's output on the console and save it to a file for later reference, you can pipe it to the `tee` command:

```
$ my-command | tee output.log
```

This is often useful if you have a long-running command and you want to watch its progress in real-time.

## To be continued...

In the [next lesson](../02-text-processing/README.md), we'll be looking at how to use standard UNIX command line tools to inspect and manipulate text files.

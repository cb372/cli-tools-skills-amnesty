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

## Creating and deleting files and directories

## Finding files

## Piping and redirection

# Shell scripting

If you haven't done so already, please clone the git repo and `cd` into the `03-shell-scripting` directory.

## The shell

Whenever you type stuff in your terminal, you are interacting with the shell. This is a layer that sits on top of the operating system and acts as the user interface. 

When you type `cat README.md`, you are not running the `cat` command directly. Instead, the shell interprets this string and then calls the `cat` command for you, passing it the argument `README.md`.

A slightly more interesting example: the shell provides so-called "glob" expansion, which recognises characters like "*". So when you type `cat *.md`, the shell finds all files in the current directory that have the extension `.md`, and then passes them as parameters to the `cat` command.

## Variables

You can declare variables using an equals sign, and then reference them using a dollar sign:

```
greeting=hello  # Note the lack of spaces. You must NOT have a space before the equals sign

echo $greeting  # prints "hello"

# if the boundaries of the variable name are ambiguous, wrap it in curly braces 
echo weusuallysay${greeting}whenwemeetpeople  
```

## Quoting

The difference between single quotes and double quotes is a common source of confusion, but the rules are quite simple.

* In general, you don't need any quotes, e.g.

    ```
    echo Hello there  # prints "Hello there"

    echo $greeting is a greeting  # prints "hello is a greeting"
    ```

* Use double quotes if you have a string containing spaces and you want to treat it as a single argument, e.g.

    ```
    first_arg=This is the first argument
    second_arg=123

    ./some-script.sh "$first_arg" $second_arg
    ```

    If you have an unknown string that potentially contains spaces, e.g. user input, then it's safest to wrap it in double quotes just in case.

* Use single quotes if you want to disable shell expansion of variables, globs, etc.:

    ```
    echo *  # prints "README.md create-files.sh" because of shell expansion

    echo '*'  # prints "*" because single quotes disable the expansion

    echo 'This $greeting will not be expanded'  # prints "This $greeting will not be expanded"
    ```

## Anatomy of a shell script

```
#!/bin/bash
#
# Useful comment explaining what the script does
#
# Usage:   my-script.sh first-argument [second-optional-argument]
# Example: my-script.sh hello goodbye

... declare any functions at the top of the file ...

... validate the arguments passed to the script ...

... save the arguments with nice human-readable names ...

... main body of the script ...
```

By convention the filename usually ends with `.sh`, but it doesn't have to.

## Running a script

You need to `chmod` the file to make it executable before you can run it, e.g.

```
$ chmod u+x my-script.sh
```

You execute it by simple typing its name, followed by any arguments you want to pass to it. If the script is in the current directory, you need to prefix it with `./`, e.g.

```
$ ./my-script.sh foo bar
```

## Arguments

The arguments passed to the script are available as variables called `$1`, `$2`, etc. There are also special variables available:

* `$#` is the number of arguments
* `$@` contains all the arguments

### Checking arguments

Here are a couple of common patterns for validating the arguments passed to the script.

```
# Give the parameters useful names whilst also checking that they are present
input_file=${1?Input file parameter missing}
output_file=${2?Output file paramter missing}
```

```
# Check that the number of arguments is as expected. If not, print a usage message and exit with error.
if [ $# -ne 2 ]; then
  echo Usage: myscript.sh input-file output-file
  exit 1
fi
```

```
# Shorthand form for the above
[ $# -ne 2 ] && echo "Usage: myscript.sh input-file output-file" && exit 1
```

If you want to do more complex parsing of options and arguments, google for "getopts".

### Default arguments

If your script takes an optional argument, you can provide a default value as follows:

```
output_file=${1:output.txt}
```

This will use the first argument supplied to the script, if it exists. Otherwise it will use the value `output.txt`.

## Running external programs

Executing a command such as `cat`, `grep`, and so on is simple: just write it in your script, exactly as you would in the terminal, e.g.

```
pattern=h.*o
grep $pattern README.md
```

Immediately after you run the command, its exit value is available as `$?`.

If you want to save the output of the command as a variable, you can do so using `$(...)`

```
cmd_output=$(my-command foo bar)
```

## Checking where you are

A common mistake is to assume that filesystem paths are relative to the script's directory. This is not always true: somebody might run your script from a different directory, and relative paths are calculated relative to the current working directory.

So if you have the following line in your script, the file `output.txt` may not be created where you expect.

```
my-command foo bar > output.txt
```

Solution: use the following incantation to work out where the script is, and then make all paths relative to that.

```
my_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

my-command foo bar > $my_directory/output.txt
```

## Looping

Looping from 1 to N:

```
for i in $(seq $N); do
  echo The value of i is $i
done
```

Looping over the lines of a file:

```
while read next_line; do
  echo The next line of the file is $next_line
done < input.txt
```

## Functions

You can declare a function like so:

```
function echo_both_args {
  # The arguments passed to the function are available as $1, $2, ...
  echo "$1 $2"
}
```

and call it just by writing its name, with the arguments you want to pass:

```
echo_both_args hello there
```

## Exercise

Let's write a bash script! There is a script called `create-files.sh` in the `03-shell-scripting` directory, but most of it is unimplemented. Your job is to replace the `TODO` comments with real code.

You can run the script from your terminal as follows:

```
$ ./create-files.sh 5 
```

## Further reading/reference

The site I usually use as a reference is [http://tldp.org/LDP/abs/html/](http://tldp.org/LDP/abs/html/). It's full of good examples.

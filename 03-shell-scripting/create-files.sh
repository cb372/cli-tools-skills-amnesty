#!/bin/bash
#
# Generates a user-specified number of text files 
# and writes a user-specified string into all of them.
#
# The files will be created inside a `data` directory in the same directory as this script.
#
# Usage:   create-files.sh number-of-files file-content
#
# Example: create-files.sh 5 "hello there"
# This will create 5 files, all containing the text "hello there".

echo TODO check that the arguments have been correctly supplied.
# This can be as strict as you like, e.g. 
#  - checking that you have at least $1 and $2, or checking you have exactly 2 arguments
#  - checking that the first argument is a number greater than zero

echo TODO save the arguments as nicely-named variables

echo TODO create a directory called 'data' in the same directory as the script

echo TODO loop from 1 to N

echo TODO for every number i, create a file data/i.txt and write the required string to it

echo Done!

# More stuff to try if you finish early:
# - make the second argument optional, and take the input from stdin if the argument is not supplied, e.g. echo hello there | ./create-files.sh 5
# - write the current date and time to the files, as well as the user-supplied text, e.g. "hello there at 22:13 on 23-11-2015"

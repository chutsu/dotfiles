# SH

## Condition Operators
### Binary operators

  -eq (arg1 is equal to arg2)
  -ne (arg1 is not equal to arg2)
  -lt (arg1 is less than arg2)
  -le (arg1 is less than or equal to arg2)
  -gt (arg1 is greater than arg2)
  -ge (arg1 is greater than or equal to arg2)

### String operators

  -z string (length of string is zero)
  -n string (length of string is non-zero)
  string1 == string2 (strings are equal)
  string1 != string2 (string are not equal)
  string1 < string2 (string1 sorts before string2)
  string1 > string2 (string1 sorts after string2)

### File operators

  -a file (file exists)
  -b file (file exists and is a block special)
  -c file (file exists and is a character special)
  -d file (file exists and is a directory)
  -e file (file exists)
  -f file (file exists and is a regular file)
  -g file (file exists and is set-group-id)
  -h file (file exists and is a symbolic link)
  -k file (file exists and is sticky)
  -p file (file exists and is a named pipe)
  -r file (file exists and is readable)
  -s file (file exists and has a size greater than zero)
  -t fd   (file descriptor is open and refers to a terminal)
  -u file (file exists and is set-user-id)
  -w file (file exists and is writable)
  -x file (file exists and is executable)
  -O file (file exists and is owned by the current user)
  -G file (file exists and is owned by the current user group)
  -L file (file exists and is a symbolic link)
  -S file (file exists and is a socket)
  -N file (file exists and has been modified since last read)
  file1 -nt file2 (file1 is newer by modification date than file2)
  file1 -ot file2 (file1 is older by modification date than file2)
  file1 -ef file2 (file1 and file2 have the same device and inode)


## What is `2>&1`
1 is stdout. 2 is stderr.

tl;dr: redirects stderr to stdout

Here is one way to remember this construct (although it is not entirely
accurate): at first, 2>1 may look like a good way to redirect stderr to stdout.
However, it will actually be interpreted as "redirect stderr to a file named
1". & indicates that what follows is a file descriptor and not a filename. So
the construct becomes: 2>&1.


## What is the difference between $() and backticks?
There is no semantic difference. The backtick syntax is the older and less
powerful version. See man bash, Section "Command Substitution". If your shell
supports the $() syntax, prefer it because it can be nested.

While there are attempts to perform nested back ticks. For example:

    `echo\ \`foo\``

Expressions like `echo `foo`` (as opposed to $(echo $(foo))) won't work in
general because of the inherent ambiguity because each `` can be opening or
closing. It might work for special cases due to luck or special features.

# Readme

## Quick start guide

`wget https://bitbucket.org/awesomefireduck/bash-include/raw/e348acee7e7c8880b2efe7d1928cb013c48ab334/include.bash -O $HOME/bin/include.bash`  
or  
`curl https://bitbucket.org/awesomefireduck/bash-include/raw/e348acee7e7c8880b2efe7d1928cb013c48ab334/include.bash -o $HOME/bin/include.bash`

Then source the file in every script you want to include in.
Like so:
```
#!/bin/bash
source $HOME/bin/include.bash #or full path
```

## What it does
With this `source`d into your script you can use the include statement to include a script from

## Tutorial / Examples

### 1. Preparation
The file is located at `~/bin/include.bash`

First we make some files:

`~/bin/include/colours.sh` a file containing variables we want to include in another script
```
#!/bin/bash

apple="sour green"
pepper="spicy red"
```

`~/my_testscript` the actual script we want to `include` stuff in
```
#!/bin/bash

# so we can use 'include'
source $HOME/bin/include.bash

# print the values of these variables (which are not yet defined)
echo "$apple"
echo "$pepper"
```
Now we run `chmod +x ~/bin/my_testscript` so we can run our script

### 2. include a file
We are now able to run `~/my_testscript` and see what the output is.  
You should get three empty lines since none of the variables should have a value.
  
Now we add an include to `~/my_testscript` so that it looks like this:
```
#!/bin/bash

# so we can use 'include'
source $HOME/bin/include.bash

# include the colour variables
include colours.sh

# print the values of these variables
echo "$apple"
echo "$pepper"
```
It should output the following, each on it's own line: 
`sour green`  
`spicy red`  
  
`insert` first looks for the file (`colours.sh`) in the same dir as the script it's in. If it can't find it there it looks in `~/bin/include`, and then in `~/bin`. This means `include` found it at `~/bin/include/colours.sh`. That's where our script's variables got their values.

### 3. Local first
Let's create a new file:
`~/colours.sh` 
```
#!/bin/bash

apple="crunchy red"
pepper="sweet green"
```
Already feel where we're going? great! If not, that's okay too.

Let's see what the script prints when we run it:  
`crunchy red`  
`sweet green`  
  
Do you remember the order in which `include` looks for the file? (see \# 2.)  
It already found it right next to `~/my_testscript`, so it uses that and stops.

### 4. Overriding local include
If you do want to have include use the one in `~/bin/include` (or if not found there, the one in `~/bin`), you'll have to use the `+local` option like so:  
`~/my_testscript`
```
#!/bin/bash

# so we can use 'include'
source $HOME/bin/include.bash

# include the colour variables
include colours.sh +local     # <--

# print the values of these variables
echo "$apple"
echo "$pepper"
```
If we now run `~/my_testscript` it will output just like in the second part:  
`sour green`  
`spicy red`  


It seems counter-intuitive to use a + to disable an option, but this is consistent with bash's options like `set -e #exit on error` and `set +e #not exit on error`

That's it folks!

## Short roadmap:  
* actually using ~/bin/include/ (before looking in ~/bin/)
* more than one file per include statement
* option for `both` so that it not stops if found locally
* DONE! locally checking next to file included in (instead of PWD)


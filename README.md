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
The file is located at `~/bin/include.bash`

First we make some files:

`~/bin/include/colours.sh` a file containing variables we want to include in another script
```
#!/bin/bash

green="like grass"
blue="like the sky"
```

`~/bin/my_testscript` the actual script we want to `include` stuff in
```
#!/bin/bash

# so we can use 'include'
source $HOME/bin/include.bash

# include the colour variables
include colours.sh

# print the values of these variables
echo "$green"
echo "$red"
echo "$blue"
```
Now we run `chmod +x ~/bin/my_testscript` so we can run our script

We are now able to run `~/bin/my_testscript` and see what the output is



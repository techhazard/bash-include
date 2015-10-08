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

## Examples

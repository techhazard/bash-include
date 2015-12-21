set -x #print all lines
include
if [[ $? -ne 127 ]]; then exit 1; fi

set -e #exit on error
oldhome="$HOME"
HOME="$PWD/home"

#the script that we test
source ../include.bash

####################
echo local include #
####################

#should change after include
apple="sour green"
pepper="spicy red"

test "$apple" = 'sour green'
test "$pepper" = "spicy red"

include file1.sh

test "$apple" = "crunchy red"
test "$pepper" = "sweet green"


#####################
echo global include #
#####################

#should changee
apple="sour green"
pepper="spicy red"

#should not include
set +e #temp
# should fail and return 1
include file_that_does_not_exist_in_the_global_include_directories.sh +local
if [[ $? -ne 1 ]]; then exit 1; fi
set -e

test "$apple" = 'sour green'
test "$pepper" = "spicy red"

###########################
echo  global include fail #
###########################

HOME="$oldhome"
#should not change
apple="sour green"
pepper="spicy red"

#should not include
set +e #temp
# should fail and return 1
include file_that_does_not_exist_in_the_global_include_directories.sh +local
if [[ $? -ne 1 ]]; then exit 1; fi
set -e

test "$apple" = 'sour green'
test "$pepper" = "spicy red"


#########################
echo local include fail #
#########################

#should not change
apple="sour green"
pepper="spicy red"

#should not include
set +e #temp
# should fail and return 1
include file_that_does_not_exist_in_this_directory.sh
if [[ $? -ne 1 ]]; then exit 1; fi
set -e

test "$apple" = 'sour green'
test "$pepper" = "spicy red"


######################
echo symlink include #
######################

#should change after include
apple="sour green"
pepper="spicy red"

test "$apple" = 'sour green'
test "$pepper" = "spicy red"

include link.sh

test "$apple" = "crunchy red"
test "$pepper" = "sweet green"

##################################
echo broken symlink include fail #
##################################

#should not change
apple="sour green"
pepper="spicy red"

#should not include
set +e #temp
# should fail and return 1
include broken_link.sh
if [[ $? -ne 1 ]]; then exit 1; fi
set -e

test "$apple" = 'sour green'
test "$pepper" = "spicy red"

exit 0

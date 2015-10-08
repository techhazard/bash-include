#!/bin/bash


include_local() {


# verify dir of scrip
startdir=$(dirname $0)
FIND_CONF_DIR="$0"
while [ -h "$FIND_CONF_DIR" ]; do # resolve $FIND_CONF_DIR until the file is no longer a symlink
  confdir="$( cd -P "$( dirname "$FIND_CONF_DIR" )" && pwd )"
  FIND_CONF_DIR="$(readlink "$FIND_CONF_DIR")"
  [[ $FIND_CONF_DIR != /* ]] && FIND_CONF_DIR="$DIR/$FIND_CONF_DIR" # if $FIND_CONF_DIR was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
currdir="$( cd -P "$( dirname "$FIND_CONF_DIR" )" && pwd )"
echo c $currdir

if [[ -f "$currdir/$1" ]];
then
	source "$currdir/$1"
	return 0
fi
#echo "script not found locally"
return 1
}


include_global() {
if [[ -f "$HOME/bin/$1" ]];
then
	source "$HOME/bin/$1"
	return 0
fi
return 1
}


include () {
local target_script="$1"
declare -A options

# Split options
for opt in ${@:2};
do	case $opt in
		+*)
			options[${opt#"+"}]=0
			;;
		-*)	
			options[${opt#"-"}]=1
			;;
	esac;
done
#############

# fer debug
#local
#echo "'${options[local]}'"




if [[ -z ${options[local]} ]];
then
	#echo "both, local first"
	include_local "$target_script"
	if [[ $? -ne 0 ]];
	then
		include_global "$target_script"
		return $?
	fi

elif [[ ${options[local]} -eq 1 ]];
then
	#echo "local"
	include_local "$target_script"
	return $?

else [[ ${options[local]} -eq 0 ]];
	#echo "global"
	include_global "$target_script"
	return $?
fi

}

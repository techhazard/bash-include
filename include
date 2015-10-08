#!/bin/bash


include_local() {


if [[ -f "$PWD/$1" ]];
then
	source "$PWD/$1"
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
		non*)
			options[${opt#"non"}]=0
			;;
		*)	
			options[$opt]=1
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

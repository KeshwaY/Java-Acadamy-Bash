#!/bin/bash
if (( $# < 1 ))
then
	echo "Usage: fs.sh <name> [<directory>]"
fi

FILE=$1
DIR=""
if [[ -d $2 ]]
then
	DIR=$2
else
	DIR=$(pwd)
fi

OIFS="$IFS"
IFS=$'\n'

look_for_file() {
	local FILE_NAME=$1
	local ENTRY=$2
	
	if [ -z "$(ls -A $ENTRY)" ]
	then
		return 0
	fi

	if [[ -d $ENTRY ]]
	then
		for INNER_ENTRY in $ENTRY/*
			do
				look_for_file $FILE_NAME $INNER_ENTRY
			done
	else
		local ENTRY_NAME=$(basename $ENTRY)
		if [[ "$ENTRY_NAME" == *"$FILE_NAME"* ]]
		then
			echo $ENTRY
		fi	
	fi
}

look_for_file $FILE $DIR
IFS="$OIFS"


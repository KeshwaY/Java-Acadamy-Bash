#!/bin/bash
DIR=""
if [[ -d $1 ]]
then
	DIR=$1
else
	DIR=$(pwd)
fi

OIFS="$IFS"
IFS=$'\n'

print_dir() {	
	local LAST=$2
	echo $LAST$(basename $1):

	if [[ ${#LAST} -eq 0 ]]
	then
		LAST+="|"
	fi

	LAST+="--"
	
	if [[ -z "$(ls -A $1)" ]]
	then
		return 0
	fi
	for ENTRY in $1/*
	do
		
		if [[ -d $ENTRY ]]
		then
			print_dir $ENTRY $LAST 
		else
			echo $LAST$(basename $ENTRY)
		fi
	done
}

print_dir $DIR ""
IFS="$OIFS"

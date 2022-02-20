#!/bin/bash
DIR=$(pwd)

print_dir() {	
	local LAST=$2
	echo $LAST$(basename $1):

	if [[ ${#LAST} -eq 0 ]]
	then
		LAST+="|"
	fi

	LAST+="--"
	
	if [ -z "$(ls -A $1)" ]
	then
		return 0
	fi
	for ENTRY in $1/*
	do
		
		if [ -d $ENTRY ]
		then
			print_dir $ENTRY $LAST 
		else
			echo $LAST$(basename $ENTRY)
		fi
	done
}

print_dir $DIR ""

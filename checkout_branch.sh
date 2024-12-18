#!/bin/bash

usage="Usage: ./$(basename "$0") jira_url -- script to checkout a git branch from a jira url"

if [ "$1" == "" ]; then
	echo $usage
	exit 1
fi

ticket=`echo "${1##*/}"`
git checkout `git fetch && git branch -a | grep $ticket | head -n 1` 

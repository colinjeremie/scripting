#!/bin/bash

usage="Usage: ./$(basename "$0") jira_url -- script to checkout a new git branch from a jira url"

if [ "$1" == "" ]; then
	echo $usage
	exit 1
fi

git checkout -b `generate_branch.sh $1`

#!/bin/bash

ref=`git status | head -n 1 | grep -o -E 'TVAPPS-[0-9]+'`
user=`echo "$JIRA_EMAIL:$JIRA_TOKEN"`
base_url=`echo "https://francetv.atlassian.net/rest/api/3/issue/"`
usage="Usage: ./$(basename "$0") jira_url -- script to generate a commit message from a jira url"

if [ "$JIRA_EMAIL" == "" ] || [ "$JIRA_TOKEN" == "" ]; then
	echo "You need to set the env variables JIRA_EMAIL and JIRA_TOKEN"
	exit 1
fi

function execute() {
	curl -s --request GET --url "https://francetv.atlassian.net/rest/api/3/$1" --user $user --header 'Accept: application/json'	
}

res=`execute "issue/$ref"`

summary=`echo "$res" | jq -r .fields.summary`
echo "[$ref] $summary"


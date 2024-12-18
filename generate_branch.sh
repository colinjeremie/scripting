#!/bin/bash

ref=`echo "${1##*/}"`
user=`echo "$JIRA_EMAIL:$JIRA_TOKEN"`
base_url=`echo "https://francetv.atlassian.net/rest/api/3/issue/"`
usage="Usage: ./$(basename "$0") jira_url -- script to generate a git branch from a jira url"

if [ "$JIRA_EMAIL" == "" ] || [ "$JIRA_TOKEN" == "" ]; then
	echo "You need to set the env variables JIRA_EMAIL and JIRA_TOKEN"
	exit 1
fi

if [ "$1" == "" ] || [ "$1" == "-h" ]; then
	echo $usage
	exit 1
fi

function execute() {
	curl -s --request GET --url "https://francetv.atlassian.net/rest/api/3/$1" --user $user --header 'Accept: application/json'	
}

res=`execute "issue/$ref"`

id=`echo "$res" | jq -r .fields.issuetype.id`
summary=`echo "$res" | jq -r .fields.summary | tr ' ' _ | tr '/' _ | tr -d "[]()'\":;" | tr '[:upper:]' '[:lower:]' | sed 'y/āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ/aaaaeeeeiiiioooouuuuüüüüAAAAEEEEIIIIOOOOUUUUÜÜÜÜ/'`
key=`echo "$res" | jq -r .key`
type=""

if [ "$id" == "10001" ]; then
	type="feature"
elif [ "$id" == "10004" ] || [ "$id" == "10034" ]; then
	type="fix"
elif [ "$id" == "10012" ]; then
	type="tech"
elif [ "$id" == "10002" ]; then
	type="task"
elif [ "$id" == "10563" ]; then
	type="epic"
elif [ "$id" == "10010" ]; then
	type="poc"
else
	echo "Issue type \"$id\" is unknown, feature will be used"
	type="feature"
fi

echo "$type/$key-$summary"

#!/bin/bash

if [[ $1 == "" ]]; then
    echo "First arg is story points"
    exit
fi

jira issue create -t Task -a=$(jira me) --web --custom sprint=$(jira sprint list --table --plain --columns=id --state=active --no-headers) -P TRAFFIC-16924 --custom sp=$1

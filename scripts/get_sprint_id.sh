#!/bin/bash

#mkdir -p ~/.config/jira-cli/
id=`jira sprint list --table --plain --columns=id --state=active --no-headers`
echo $id

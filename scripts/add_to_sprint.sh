#!/bin/bash

id=`get_sprint_id.sh`
jira sprint add $id $1

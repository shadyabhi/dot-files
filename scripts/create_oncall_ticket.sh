#!/bin/bash

jira issue create -t Sub-task -P `cat ~/scripts/ONCALL_TICKET` -a arastogi

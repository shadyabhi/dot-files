#!/bin/bash

jira issue list --order-by updated -a$(jira me)

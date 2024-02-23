#!/usr/bin/bash

WF_JOB_ID=$1
SERVER_ENDPOINT=localhost:8080/workflow/job/${WF_JOB_ID}
JSON_RESPONSE=$(curl -v -X GET "$SERVER_ENDPOINT" 2> /dev/null)
echo ${JSON_RESPONSE} | python -m json.tool

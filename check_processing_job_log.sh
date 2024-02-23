#!/usr/bin/bash

JOB_ID=$1
SERVER_ENDPOINT=localhost:8080/processor/log/${JOB_ID}
curl -v -X GET "$SERVER_ENDPOINT" 2> /dev/null

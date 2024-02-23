#!/usr/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

SERVER_ENDPOINT=localhost:8080/workflow/run
METS_PATH=$SCRIPT_DIR/Prinzenraub-DHd2024/data/mets.xml
WORKFLOW_PATH=$SCRIPT_DIR/workflow.txt
PAGE_RANGE=p0001..p0010
AGENT_TYPE=worker

JSON_RESPONSE=$(curl -v -X POST "$SERVER_ENDPOINT?mets_path=$METS_PATH&page_id=$PAGE_RANGE&page_wise=True&agent_type=$AGENT_TYPE" \
-H "Content-type: multipart/form-data" \
-F "workflow=@$WORKFLOW_PATH" 2> /dev/null)
echo ${JSON_RESPONSE} | python -m json.tool

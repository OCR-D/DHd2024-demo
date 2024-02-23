#!/usr/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ocrd network processing-server $SCRIPT_DIR/ps_config_with_workers.yml --address "localhost:8080"

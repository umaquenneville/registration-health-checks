#!/usr/bin/env bash

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
    cd ${SCRIPT_DIR}/src/main/bash/daily/
    pwd 
    . register-daily-checks.sh
}

main

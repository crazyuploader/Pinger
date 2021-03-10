#!/usr/bin/env bash
set -eu
set -o pipefail

# Shell Script to do MTR for a server(s) specified in "servers.txt" file

DATE=$(date "+%d%m%y")
TIME=$(date "+%H%M%S")

function DO_MTR() {
    echo "MTR for ${1}"
    mtr -wrzc 25 "${1}"
    echo ""
}

if [[ ! -f "servers.txt" ]]; then
    echo "'servers.txt' file not found"
    echo "Exiting..."
    exit 1
fi

if [[ -z "$(command -v mtr)" ]]; then
    echo "MTR not found"
    echo "Exiting..."
    exit 1
fi

if [[ ! -d "out" ]]; then
    mkdir out
fi

if [[ ! -d "out/${DATE}" ]]; then
    mkdir -p out/"${DATE}"
fi

SERVERS="$(cat servers.txt)"
for SERVER in $SERVERS; do
    DO_MTR "${SERVER}" | tee -a out/"${DATE}"/"${TIME}".log
done

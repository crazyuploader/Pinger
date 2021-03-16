#!/usr/bin/env bash
set -eu
set -o pipefail

# Shell Script to do MTR for a server(s) specified in "servers.txt" file

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__SERVERS="${__DIR}/servers.txt"
__LOGDIR="/var/pinger"

DATE=$(date "+%d%m%y")
TIME=$(date "+%H%M%S")

function DO_MTR() {
    echo "MTR for ${1}"
    mtr -wrzc 10 "${1}"
    echo ""
}

if [[ ! -f "${__SERVERS}" ]]; then
    echo "'servers.txt' file not found"
    echo "Exiting..."
    exit 1
fi

if [[ -z "$(command -v mtr)" ]]; then
    echo "MTR not found"
    echo "Exiting..."
    exit 1
fi

if [[ ! -d "${__LOGDIR}" ]]; then
    mkdir "${__LOGDIR}"
fi

if [[ ! -d "${__LOGDIR}/${DATE}" ]]; then
    mkdir -p "${__LOGDIR}/${DATE}"
fi

SERVERS="$(cat "${__SERVERS}")"
for SERVER in $SERVERS; do
    DO_MTR "${SERVER}" | tee -a "${__LOGDIR}/${DATE}/${TIME}".log
done

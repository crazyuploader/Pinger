#!/usr/bin/env bash
set -eu
set -o pipefail

# Shell Script to do MTR for a server(s) specified in "servers.txt" file

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__SERVERS="${__DIR}/servers.txt"
__LOGDIR="/var/pinger"
__ASN="$(curl --silent ifconfig.co/asn)"

YEAR=$(date "+%Y")
MONTH=$(date "+%b")
DAY=$(date "+%d")
TIME=$(date "+%H%M")

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

if [[ ! -d "${__LOGDIR}/${__ASN}/${YEAR}/${MONTH}/${DAY}" ]]; then
    mkdir -p "${__LOGDIR}/${__ASN}/${YEAR}/${MONTH}/${DAY}"
fi

echo "Running mtr.py at: ${TIME}"
"$__DIR"/mtr.py > /dev/null 2>&1
if [[ -f "out.md" ]]; then
    mv out.md "${__LOGDIR}/${__ASN}/${YEAR}/${MONTH}/${DAY}/${TIME}".md
else
    echo "No output from mtr.py"
fi

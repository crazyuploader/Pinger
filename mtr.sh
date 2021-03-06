#!/usr/bin/env bash
set -eu
set -o pipefail

# Shell Script to do MTR for a server(s) specified in "servers.txt" file

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__SERVERS="${__DIR}/servers.txt"
__LOGDIR="/var/pinger"

YEAR=$(date "+%Y")
MONTH=$(date "+%b")
DAY=$(date "+%d")
TIME=$(date "+%H%M")
CURRENT_TIME="$(date --rfc-3339=seconds)"

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

if [[ ! -d "${__LOGDIR}/${YEAR}/${MONTH}/${DAY}" ]]; then
    mkdir -p "${__LOGDIR}/${YEAR}/${MONTH}/${DAY}"
fi

"$__DIR"/mtr.py
echo -e "# As of ${CURRENT_TIME}\n\n$(cat out.md)" > out.md
cp out.md "${__LOGDIR}"/latest.md
mv out.md "${__LOGDIR}/${YEAR}/${MONTH}/${DAY}/${TIME}".md

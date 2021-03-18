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

function PRINT_HOST() {
    IP="$(dig +short A "${1}")"
    if [[ -n "${IP}" ]]; then
        echo "MTR for ${1} (${IP})"
    else
        echo "MTR for ${1}"
    fi
}

function DO_MTR() {
    PRINT_HOST "${1}"
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

if [[ ! -d "${__LOGDIR}/${YEAR}" ]]; then
    mkdir -p "${__LOGDIR}/${YEAR}"
fi

if [[ ! -d "${__LOGDIR}/${YEAR}/${MONTH}" ]]; then
    mkdir -p "${__LOGDIR}/${YEAR}/${MONTH}"
fi

if [[ ! -d "${__LOGDIR}/${YEAR}/${MONTH}/${DAY}" ]]; then
    mkdir -p "${__LOGDIR}/${YEAR}/${MONTH}/${DAY}"
fi

SERVERS="$(cat "${__SERVERS}")"
for SERVER in $SERVERS; do
    DO_MTR "${SERVER}" | tee -a "${__LOGDIR}/${YEAR}/${MONTH}/${DAY}/${TIME}".log
done

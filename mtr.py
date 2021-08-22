#!/usr/bin/env python3

# Python Program to run MTR every X minutes

__author__ = "Jugal Kishore"


import sys
from os.path import dirname
import shlex
import subprocess

# Global Variable(s)
PATH = sys.argv[0]
__DIR = dirname(PATH)
__SERVERS = f"{__DIR}/servers.txt"
SERVERS = []

# Read server(s) from "servers.txt" file
print("Reading servers...")
with open(__SERVERS, "r") as servers:
    servers = servers.readlines()
    for server in servers:
        SERVERS.append(server.strip())


def run_in_shell(COMMAND):
    final_command = shlex.split(COMMAND)
    PROCESSED = subprocess.run(final_command, capture_output=True)
    return PROCESSED


def bytes_to_string(BYTE):
    return BYTE.decode("utf-8").strip()


def do_mtr(SERVER):
    command = f"mtr -wrzbc 3 -m 40 {SERVER}"
    PROCESSED = run_in_shell(command)
    if PROCESSED.returncode == 0:
        return bytes_to_string(PROCESSED.stdout)
    return ""


TO_WRITE = ""
for SERVER in SERVERS:
    print("MTR for", SERVER)
    print("---\n")
    MTR = do_mtr(SERVER)
    if not MTR:
        pass
    else:
        print(MTR)
        TO_WRITE += f"### MTR for {SERVER}\n"
        TO_WRITE += "---\n\n"
        TO_WRITE += f"```\n{MTR}\n```\n\n"
    print("")

with open("out.md", "w") as final:
    final.write(TO_WRITE)

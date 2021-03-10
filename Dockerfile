#
# Created by Jugal Kishore -- 2021
#
# Using Base Image: Alpine
FROM alpine

# Adding Required Package(s)
RUN apk --no-cache add mtr bash alpine-conf

# Setting TimeZone to IST
RUN setup-timezone -z Asia/Kolkata

# Removing Stuff(s)
RUN apk del alpine-conf

# Setting Working Directory
WORKDIR /pinger

# Copy required file(s)
COPY mtr.sh mtr.sh

COPY servers.txt servers.txt

RUN mkdir out

CMD ["/bin/bash", "-c", "while true; do ./mtr.sh; sleep 300; done"]
